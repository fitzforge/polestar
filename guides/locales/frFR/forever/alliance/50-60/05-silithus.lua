-- French (frFR): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, à l'intérieur",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Prenez le bateau de {area:392} pour {area:35} et un vol pour {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, qui se promène le long des canaux",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Pour {npc:10778} : gardez-la",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, au SI:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} au {area:3197} : gardez-la",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "Ses pots se remplissent lors de la prochaine visite à Un'Goro",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, près du tram",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Prendre un vol pour {area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions du Fléau",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Les Champions du Fléau (59) parcourent {area:2270}, au nord de {area:2268}. Passez le {item:13156} de {npc:11063} au-dessus de chacun d'eux une fois tué : les crânes qui entrent en résonance sont ceux qu'il veut. Attirez-les un par un.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, sur les Champions du Fléau",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Chromie à Andorhal : gardez-la",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Chevauchez vers le nord jusqu'à la lisière nord-est de {area:2277}.\nAttention : les trolls le long du chemin vers {area:2273} sont de niveau 57-59. Ils fuient quand leur vie est basse et appellent à l'aide, alors ils ramènent souvent des renforts.",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Chevauchez vers le sud-ouest jusqu'à {area:2261}. Le monticule de terre se trouve à l'intérieur. {npc:11886} est élite : mieux vaut être en groupe.\nAttention : environ quatre renforts non élites accompagnent Mercutio. Ils marchent jusqu'à la tombe au lieu d'apparaître sur place.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, sur {npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Chromie à Andorhal : gardez-la",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Les Écraseurs térébrants creusent plus à l'ouest ; les Pinceurs Cinglepierre, Écorcheurs Cinglepierre et Traqueuses des rochers chassent sur les mêmes sables.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Les Frappeurs térébrants creusent les dunes au nord-ouest du fort ; les Scorpides Cinglepierre et les Glisseuses du sable rôdent tout autour.",
	-- ["Dredge and scorpids"] = "Térébrants et scorpides",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Prenez un vol de {area:976} pour {area:541}. La hutte de {npc:8737} se trouve à {area:538}, à l'ouest du refuge ; {npc:9117} est en haut de la colline derrière.",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Prenez un vol pour {area:271} et remontez la route vers le nord en direction d'Alterac : Haggerdin campe à {area:1056}, au bord de la route.",
	-- ["For {area:3197}: keep it"] = "Pour {area:3197} : gardez-la",
	-- ["For {npc:10778}: keep it"] = "Pour {npc:10778} : gardez-la",
	-- ["For {zone:1448}: keep it"] = "Pour {zone:1448} : gardez-la",
	-- ["From {area:392}, fly to {area:976}."] = "Depuis {area:392}, prenez un vol pour {area:976}.",
	-- ["Its jars are filled on the next Un'Goro visit"] = "Ses pots se remplissent lors de la prochaine visite à Un'Goro",
	-- ["On {npc:7583}"] = "Sur {npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "Revenez à {area:3425} et prenez un vol pour {area:392}.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Chevauchez vers l'est jusqu'à la tour de {area:2742} à {area:2738} ; gravissez-la et tuez les embusqués qui surgissent pour l'objet incrusté.",
	-- ["Ride east to {npc:13220}."] = "Chevauchez vers l'est jusqu'à {npc:13220}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Chevauchez vers le nord jusqu'à la lisière nord-est de {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Continuez vers le nord jusqu'au {area:3197} et prenez un vol pour {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Sortez du cratère par le col nord-ouest jusqu'en {zone:1451}, puis continuez jusqu'à {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Chevauchez vers le sud-ouest jusqu'au {area:2261}. Le monticule de terre se trouve à l'intérieur. {npc:11886} est élite : mieux vaut être en groupe.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",
	-- ["Scourge Champions"] = "Champions du Fléau",
	-- ["Sixty {item:2592}, if you carry them"] = "Soixante {item:2592}, si vous en avez",
	-- ["Take the {area:2257} to {zone:1455}."] = "Prenez le {area:2257} jusqu'à {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Les Bêtes du goudron se vautrent dans {area:538} ; les élémentaires de feu de {area:537}, au centre, portent la cendre ; les guêpes Gorishi de {area:540}, au sud, portent la glande. Toute créature du cratère peut laisser tomber de l'{item:11018}.",
	-- ["The crater"] = "Le cratère",
	-- ["The next guide starts here in {area:392}."] = "Le guide suivant commence ici, à {area:392}.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Les Druides torturés et les Sentinelles torturées hantent le village en ruine au sud-ouest de {npc:13220}.",
	-- ["The western dunes"] = "Les dunes de l'ouest",
	-- ["The {area:2742} tower"] = "La tour de {area:2742}",
	-- ["Umber in {zone:1450}: keep it"] = "Umber à {zone:1450} : gardez-la",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "tuez des {npc:8532} à la {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, sur les Champions du Fléau",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}, sur {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}, près du tram",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, au SI:7",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, qui se promène le long des canaux",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} attend au cimetière juste à l'est de la ville ; la pierre tombale se trouve à proximité.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} se trouve à {area:392}",
}
