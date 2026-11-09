-- French (frFR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337} and {npc:5810} stand together."] = "",

	-- Step 3: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",

	-- Step 4: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} campe au bord de la route à l'est, vers {area:392}.",

	-- Step 5: Razormane camp
	["Razormane camp"] = "Camp Tranchecrin",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "",

	-- Step 6: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "",
	-- {npc:3429} Thork
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end."] = "",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine, as at 10. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Retournez vers l'est par le pont et montez le sentier jusqu'au sanctuaire de {npc:5900}, comme à l'étape 10. {npc:5900} fabrique {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler {npc:5893}, tuez-la pour obtenir {item:6655}, puis placez la braise dans le brasero.",

	-- Step 10: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {npc:2523}, votre {item:5176} et le {item:263412}",

	-- Step 12: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en haut de la tour",

	-- Step 13: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "",

	-- Step 14: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "",

	-- Step 15: Razormane camp
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks."] = "",

	-- Step 16: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "",

	-- Step 18: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin.",

	-- Step 23: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Suivez la route vers l'est jusqu'à l'avant-poste au-dessus de {area:814}.",

	-- Step 24: Durotar
	["The thunder lizards across the river"] = "",

	-- Step 25: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lézards-tonnerre de l'autre côté de la rivière",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Les Lézards-tonnerre et les Foudroyants paissent juste de l'autre côté du pont, sous {area:379}.",

	-- Step 27: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} attend sur la berge au sud de {area:379}, de l'autre côté du pont.",

	-- Step 28: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectateurs de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {zone:1411} ; ils laissent tomber la {item:6652}. Le {item:5026} vient des Tranchecrin lors de votre prochaine visite à leur camp.",

	-- Step 31: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the Crossroads to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Suivez la route vers le sud-est jusqu'à {area:392}, sur la côte.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, à l'étage",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442} : la console est dans {area:382}, plus tard",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Affiche {object:3972}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, sur le quai",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "",

	-- Step 34: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "{zone:1413} : tuez-les au passage",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "",

	-- Step 35: Ratchet
	-- {npc:3391} Gazlowe · {area:385} Northwatch Hold
	["{npc:3391}: the crates lie at the south end of the beach camp, on the walk to {area:385} at 18"] = "",

	-- Step 36: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 38: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "",

	-- Step 39: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "",

	-- Step 40: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} walks with the Kolkar at the {area:388}, later"] = "",

	-- Step 41: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "",

	-- Step 42: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk, à l'ouest de {area:382}. Fermez les trois vannes autour de la foreuse, utilisez à nouveau la console, puis prenez la {item:5089} sur l'{npc:3471}, juste à côté.\nAttention : plusieurs gardes se tiennent à portée d'aggro des vannes, réapparaissent en moins de 3 minutes environ et fuient à faible vie pour ramener de l'aide ; les monstres proches se joignent aussi au combat si vous utilisez une vanne près d'eux.",
	["Inside"] = "À l'intérieur",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "",

	-- Step 43: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Retour au camp Tranchecrin. Les Géomanciennes et les Défenseurs tiennent sa moitié est ; {npc:3438} se promène parmi eux.",

	-- Step 45: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} fabrique le {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler la {npc:5893}, tuez-la pour obtenir la {item:6655}, puis placez la braise dans le brasero.",

	-- Step 46: The Barrens
	["Sunscale raptors here count toward the heads."] = "",

	-- Step 48: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem
	["{npc:3338} by the inn first, then the innkeeper, Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate on the way out."] = "",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "",

	-- Step 49: The Stagnant Oasis
	["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank."] = "",
	["Underwater"] = "Sous l'eau",

	-- Step 50: The Crossroads
	["Back west along the road."] = "Revenez vers l'ouest par la route.",

	-- Step 51: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the Crossroads, and around the {area:388}."] = "",

	-- Step 52: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "",

	-- Step 54: Raptor Horns
	-- {quest:881} Echeyakee · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way east to {quest:881}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "",

	-- Step 55: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "",

	-- Step 56: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Lashtails = {npc:3254} Sunscale Lashtail
	["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "",

	-- Step 57: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, {npc:3448} at the south gate, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "",

	-- Step 58: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}: {npc:3033} trains you on {area:1639}."] = "",

	-- Step 59: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Lancez {spell:18960}",

	-- Step 60: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127} : {area:384}, guide suivant",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, à {area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} à {area:2361} y emmène les druides",

	-- Step 61: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "",

	-- Step 62: Fly to Ratchet
	["Crossroads flight master"] = "",

	-- Step 64: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {area:392} Ratchet
	["{npc:3446}, beside the {object:3972} poster: take it now if he did not offer it on the first {area:392} stop"] = "",

	-- Step 65: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED
	["{npc:3446}, beside the {object:3972} poster"] = "",

	-- Step 67: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "",

	-- Step 68: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:209797} (élite de niveau 20) demande un groupe de 2. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 69: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 70: Raptor nests
	["Raptor nests"] = "Nids de raptors",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them."] = "",

	-- Step 71: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "{area:1697} : tuez-les au passage",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them when the escort brings you back to {area:392}.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "",

	-- Step 72: Stolen Booty
	-- {area:385} Northwatch Hold
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "",

	-- Step 73: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "{area:385} : tuez-les au passage",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast just south of the pirate camp. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "",
	["On the top floor"] = "Au dernier étage",
	["Upstairs"] = "À l'étage",

	-- Step 74: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} est enchaîné dans le fort. Parlez-lui pour lancer l'escorte et restez près de lui : des soldats de Theramore attaquent à la sortie. Il vous ramène à {area:392}.",

	-- Step 81: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} auprès de {npc:3490} ; les herboristes en cueillent dans les plaines",

	-- Step 82: Kolkar camp
	["Kolkar camp"] = "",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "",

	-- Step 83: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Au nord vers les {area:383}. {npc:3682} campe au pied des collines ; {npc:261366}, l'ermite sur la crête derrière lui, n'a du travail pour vous qu'une fois que {npc:3682} vous y envoie.",

	-- Step 84: The Barrens: kill these as you meet them
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "Les Patriarches des savanes parcourent les plaines à l'est des collines, et les Pièges déclenchés se trouvent au milieu d'eux. {quest:876} dirige les harpies Ensorçaile dans les collines à l'ouest.\nAttention : le chemin d'accès passe près de harpies embusquées camouflées et d'une harpie élite qui patrouille.",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, si elle est encore en cours : des Faucheurs solécaille rôdent parmi les lions",

	-- Step 87: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "Le {npc:262119} et ses soldats de marine tiennent la caravane détruite au sud de {npc:261366}. Les soldats sont liés : en attirer un fait venir les autres. Attirez-les depuis le bord et courez ; ils abandonnent vite la poursuite, vous pouvez donc éclaircir le camp un par un avant d'affronter le caporal.",

	-- Step 88: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Aidez {npc:261366} : restez près de lui quand {npc:261367} et les soldats de marine de {area:21} montent la crête",

	-- Step 89: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "",

	-- Step 90: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "",

	-- Step 91: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} se trouve au bord nord de {area:382}, près de la tour de la KapitalRisk. Il contient le {item:15883} pour {quest:30}.",

	-- Step 92: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "Wizzlecrank sort du camp avec son déchiqueteur : restez avec lui et tuez tout ce qui l'attaque. {npc:3442} le récupère à {area:392}.\nAttention : la route mène vers l'ouest et monte une rampe. Une fois en haut, deux monstres de la KapitalRisk vous tendent une embuscade.",

	-- Step 93: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "",

	-- Step 94: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Les Surveillants de la KapitalRisk et Massacreurs de la KapitalRisk de la mine au nord-est de la zone laissent l'{item:5097}.",

	-- Step 95: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "",

	-- Step 96: the Crossroads
	["the Crossroads"] = "",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Il vous donne le {item:15826}",

	-- Step 97: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads."] = "",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "",

	-- Step 98: Bristleback camps
	["Bristleback camps"] = "Camps Dos-hirsute",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "",

	-- Step 99: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Suivez la {area:458} vers le sud jusqu'au {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, dans la cage",

	-- Step 100: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "",

	-- Step 103: The Crossroads
	-- {area:458} Gold Road · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3432} stands by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} propose {quest:95774} une fois {quest:4921} rendue",
	-- {npc:3428} Korran · {area:390} Field of Giants · {area:378} Camp Taurajo · {zone:1454} Orgrimmar
	["{npc:3428}: the eggs are in the {area:390}, south of {area:378}, after the {zone:1454} trip"] = "",

	-- Step 104: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "",

	-- Step 105: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "",

	-- Step 106: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "",

	-- Step 107: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "",

	-- Step 108: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} se tient dans {object:172961}, à l'ouest de la ville.",

	-- Step 109: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} est le canyon sous {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, à quelques pas",

	-- Step 110: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} se tient dans la {object:172961}, à l'ouest de la ville.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018} : {npc:4606} à {zone:1458}, dans deux guides",

	-- Step 111: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "",

	-- Step 112: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 113: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 115: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} attend sur la colline au sud de {area:392}, sur votre route vers le nord.",

	-- Step 116: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, sur n'importe quel zhévra ; des Étalons zhévra paissent autour de l'arbre",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "À l'arbre mort : invoque {quest:882}",

	-- Step 117: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "",

	-- Step 120: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vit à {area:2539}, le village troll juste à l'entrée des Serres-Rocheuses, au bout de la route qui part vers l'ouest depuis {npc:3389}.",

	-- Step 121: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "",

	-- Step 123: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop."] = "",

	-- Step 124: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "",

	-- Step 125: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Redescendez la {area:458} jusqu'au {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Gardez-la : {npc:12696} en {zone:1440}, guide suivant",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "{npc:6394}, à l'intérieur",

	-- Step 127: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran est enchaîné dans le camp huran à l'ouest de la route.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "",

	-- Step 128: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Les Têtes-tonnerre paissent dans les plaines juste au sud du {area:378}. {quest:884}, un lézard-tonnerre bleu, erre parmi eux : sa pointe caudale lance une quête.",

	-- Step 129: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	["Warriors: take {quest:1824} from {npc:6394} now, not earlier: it runs for 30 minutes from the accept. The thunderhawks and the eggs come first, the antennae last, then straight back to {npc:6394}."] = "",

	-- Step 130: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Les Faucons-tonnerre des nuages tournoient au-dessus des mêmes plaines au sud du camp.",

	-- Step 131: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer
	["South of Camp Taurajo, the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "",

	-- Step 132: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Remplissez l'{item:7766} au point d'eau des huttiers",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "",

	-- Step 133: Twitching Antennae
	["Twitching Antennae"] = "Antennes frémissantes",
	-- {area:390} Field of Giants · {npc:3387} Jorn Skyseer · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the {area:390}' mounds, just south of {npc:3387}'s thunderhawks, until you have five, then take them straight to {npc:6394} in {area:378}.\nCareful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds. Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds."] = "",
	["Twitching Antennae from the silithid"] = "Antennes mobiles sur les silithides",

	-- Step 134: Camp Taurajo
	-- {area:378} Camp Taurajo · {npc:3387} Jorn Skyseer · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} on the way to the Crossroads: {npc:3387} takes the thunderhawk wings. Warriors: {npc:6394} first, before the antennae fade."] = "",

	-- Step 135: The Crossroads
	-- {area:458} Gold Road · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3432} stands by the inn, {npc:3428} west of the north gate."] = "",

	-- Step 136: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Il propose ensuite {quest:1838} (1838, niveau 30) : elle demande {area:1717} et vous envoie partout en Kalimdor et dans les Royaumes de l'Est. Le guide de classe Guerrier {quest:1838} la couvre.",

	-- Step 138: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "",

	-- Step 140: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} forme les Paladins aux {area:1638}. Vous n'avez pas encore ce trajet aérien : volez jusqu'au {area:378}, allez vers l'ouest à travers {zone:1412} et montez par un ascenseur, puis prenez le trajet auprès de {npc:2995} sur la mesa centrale.",

	-- Step 142: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Volez jusqu'aux {area:1638} pour vous entraîner : {npc:3033} est sur la {area:1639}.",

	-- Step 143: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 145: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 146: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802} : l'accueil de {npc:3033}",

	-- Step 147: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Taurens : le {npc:11957} attend sur la colline sud au-dessus du pont. Éolides : l'{npc:272054} se tient au sud des ponts jumeaux. Ensuite, les tanières à l'est du lac : quittez votre forme, cliquez sur la statue à l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de chat blanc.",

	-- Step 150: Back to the Crossroads
	["Back to the Crossroads"] = "",
	-- {npc:3389} Regthar Deathgate
	["Fly back to the Crossroads; the road west to Stonetalon starts at {npc:3389}'s bunkers."] = "",

	-- Step 151: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "",

	-- Step 152: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "",

	-- Step 153: Grimtotem camp
	["Grimtotem camp"] = "Le camp Totem sinistre",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "",

	-- Step 154: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "",

	-- Step 155: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "",

	-- Step 156: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "",

	-- Step 157: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "",

	-- Step 158: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "La route grimpe vers le nord : c'est {area:1076}. {quest:1483} a une cabane là où la route bifurque vers l'est en direction de {area:461}.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "{quest:1483}, à l'intérieur",

	-- Step 159: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "",

	-- Step 160: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "{npc:4276}, sous terre",

	-- Step 161: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, à l'intérieur",

	-- Step 163: Malaka'jin
	-- {area:1076} Webwinder Path · {npc:12816} Xen'Zilla · {area:2539} Malaka'jin
	["Back down the {area:1076}: {npc:12816} stands just outside {area:2539}, before the village."] = "",

	-- Step 165: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Redescendez la plage après le camp pirate : la caisse de bottes et la caisse fragile avec la lentille se trouvent à son extrémité sud.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {area:14} ; ils lâchent la {item:6652}. Le {item:5026} vient des Tranchecrin, lors de votre prochaine visite de leur camp.",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "À l'est de Ziz, la KapitalRisk rase {area:461} ; l'un des Opérateurs porte les plans. {npc:4276} creuse dans la petite mine du côté est : restez avec lui pendant qu'il mine, des brutes de la KapitalRisk viennent s'en prendre à lui.\nAttention : les kobolds arrivent par vagues. La première vague est composée de combattants au corps à corps, la seconde y ajoute des lanceurs de sorts. Les monstres normaux de la mine réapparaissent vite et peuvent rejoindre le combat pendant les vagues. Un groupe est recommandé.",
	-- ["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "À l'est vers {area:1703} ; {npc:9316} se tient au camp juste au sud.",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Vers l'est jusqu'à {area:382}. Le {npc:3439} se trouve dans le camp de la KapitalRisk ; le {npc:3445} porte la clé.",
	-- ["East to {area:392}, on the coast."] = "À l'est vers {area:392}, sur la côte.",
	-- ["Fly to {area:380}"] = "Prendre un vol pour {area:380}",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the next guide's {zone:1454} visit"] = "Gardez-le : {quest:3923} se fait dans la {object:172958} d'{zone:1454}, lors du passage à {zone:1454} du prochain guide",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Gardez-la : {quest:3923} se tient devant {zone:1454} ; un guide ultérieur la rend",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Les Querelleurs et les Légions-tempête kolkar tiennent les camps au sud de {npc:3389}.",
	-- ["Kolkar camps"] = "Camps kolkar",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de la {area:380}, et autour de {area:388}.",
	-- ["On the way"] = "En chemin",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de la {area:380}, surtout au nord.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north.\nCareful: Sunscale Screechers call nearby allies within 30 yd once below 30% health, so dense packs can pull extra raptors."] = "Les trotteurs des plaines et les raptors Solécaille parcourent les plaines tout autour de la {area:380}, plus nombreux au nord.\nAttention : les Hurleurs solécaille appellent leurs alliés à moins de 30 m une fois sous 30 % de vie, les groupes serrés peuvent donc attirer des raptors en plus.",
	-- ["Plainstriders and raptors"] = "Trotteurs des plaines et raptors",
	-- ["Raptor nests"] = "Nids de raptors",
	-- ["South to {npc:3389}'s watch post on the Kolkar border."] = "Au sud vers le poste de guet de {npc:3389}, à la frontière kolkar.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de la {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",
	-- ["Southsea beach"] = "Plage des Mers du sud",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Les Rôdeurs des savanes chassent dans les plaines entre la ville et le camp Tranchecrin à l'est. Dans le camp, les Sourciers et les Tisseuses d’épines tiennent la moitié ouest, les Chasseurs le centre ; les caisses de ravitaillement se trouvent à l'extrémité est.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Les Tueuses Ensorçaile tiennent l'ouest de {area:383} ; elles portent les anneaux.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "Les Tueuses Ensorçaile tiennent l'ouest de {area:383} ; ce sont elles qui portent les anneaux.\nAttention : des harpies embusquées et camouflées attendent dans la zone et restent cachées jusqu'à ce que vous approchiez. Une harpie élite de niveau 19 patrouille aussi par là.",
	-- ["The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Le prochain guide commence ici et vous emmène à {zone:1454}, puis au zeppelin pour les {zone:1420}.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Les pirates campent sur la plage au sud de {area:392}. Les tas de pièces compliquées se trouvent dans le sable parmi eux.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Les pirates campent sur la plage au sud de {area:392}. Les tas de pièces compliquées sont dans le sable au milieu d'eux.\nLes pirates campent sur la plage au sud de {area:392} ; le {npc:3467} se tient à son extrémité sud.",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Les bassins se trouvent juste au nord de {npc:3389}. Entrez dans l'eau pour les explorer ; les Champignons chargés pour Helbrim poussent autour. Tuez chaque kolkar sur votre passage pour les brassards.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Les trois nids se trouvent ensemble à {area:1697}, au sud-ouest de l'oasis ; des Faucheurs solécaille les gardent.",
	-- ["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Les seaux à outils avec les rondelles se trouvent autour du site de forage de la KapitalRisk, dans {area:382}, à l'est de {npc:9316}.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk à l'ouest de {area:382}. Fermez les trois vannes autour du foreur, utilisez de nouveau la console, puis prenez la {item:5089} sur {npc:3471}, à côté.",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim campe au bord de la route de {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Revenez vers le sud jusqu'à la {area:380}. Le guide suivant commence ici et vous emmène à {zone:1454} et au zeppelin pour {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Revenez vers l'ouest par la route jusqu'à la {area:380}.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Sourciers, Tisseuses d'épines et Chasseurs Tranchecrin tiennent le camp à l'est de {area:380}. Les caisses de provisions se trouvent à son extrémité est. Guerriers : {object:58369} se trouve dans le camp. Chamans : les huttiers lâchent {item:5026}. Tuez les Rôdeurs des savanes que vous croisez pour leurs griffes.\nAttention : le coffre se trouve à côté d'un chariot cassé, gardé par une paire de Tranchecrin, dont des chasseurs qui peuvent attirer d'autres huttiers dans le combat.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "À l'ouest vers {area:383}. Les harpies Ensorçaile y nichent partout ; chacune peut laisser tomber une serre. {quest:819} se trouve dans leurs collines.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "Vers l'ouest jusqu'à {area:383}. Les harpies Ensorçaile nichent partout ; n'importe laquelle peut lâcher une serre. {quest:819} se trouve dans leurs collines.\nAttention : il y a 2 Embusquées Ensorçaile (niveau 17-18). Elles restent camouflées grâce à Furtivité tant qu'elles ne sont pas en combat.",
	-- ["Zhevra"] = "Zhévras",
	-- ["Zhevra Runners graze north and east of town."] = "Les Messagers zhévra paissent au nord et à l'est de la ville.",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885} : utilisez une moitié au {area:2362}",
	-- ["{item:5055} on the way"] = "{item:5055} en chemin",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033} : Forme de félin",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033} : Guérison du poison",
	-- ["{npc:3267} on the way"] = "{npc:3267} en chemin",
	-- ["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} à {area:392} : plus tard, en chemin",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",
	-- ["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} campe au bord de la route de la {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301} : {area:228} en {zone:1421}, guide suivant",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn."] = "{quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.\nAttention : des Chasseresses des savanes errent autour du repaire. Elles réapparaissent vite et rejoignent souvent le combat aux côtés de {quest:881} : éliminez-les avant de souffler dans la corne.",
}
