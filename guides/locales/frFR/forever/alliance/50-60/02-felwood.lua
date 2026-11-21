-- French (frFR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, dans les ruines juste à l'est de {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, à l'intérieur",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920} : {quest:86577}, sur les ours et les loups que vous croisez en {zone:1448}",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554}, le furbolg, se tient au bord de la route juste au sud du {area:2479}.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Les furbolgs Mort-bois vivent dans le village juste au sud-ouest de {npc:11554} ; gardez les Coiffures de plumes mort-bois qu'ils laissent tomber."
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} attend à l'extrémité nord de {zone:1448}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Les satyres Jadefeu tiennent le vallon à l'ouest de la route, avec {npc:9454} au fond.\nAttention : les Traqueurs des ombres Jadefeu (niveau 51-52) utilisent Camouflage et {spell:7992} et sont furtifs : ils se joignent souvent aux combats sans y être invités.\nDes Limons maudits glissent dans les ruisseaux du vallon : tuez-les et utilisez le Bocal à limon vide de Laris sur leurs restes.",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Attention : {npc:9454} (54) se tient au fond des {area:2481}, vers 32.2,67.1, entouré de Traqueurs de l'ombre : éliminez-les un par un, puis attirez-le seul avec toute votre vie.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949} : des Limons souillés glissent autour des bassins gangrenés de {area:1763}",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Organes putrescents : tuez-les au passage",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Les ours Grifferage et les loups Pattegangrène de {zone:1448} portent les organes putrescents que veut {npc:10920} : les Ours et Loups (47-48) du sud et les Écharpeurs et Charognards (49-50) le long de la route au nord de {area:1763}. Tuez-les en chevauchant entre les étapes.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Suivez la route vers le nord jusqu'au val criblé de cratères et rendez-vous à chaque cratère, en tuant les Bêtes d'entropie et les Horreurs entre eux.\nAttention : une {npc:7136} (53, élite) se tient parmi les cratères : contournez-la.",
	["First crater"] = "Premier cratère",
	["Second crater"] = "Deuxième cratère",
	["Third crater"] = "Troisième cratère",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Les tréants Crochebois de {area:1767}, à l'est de {area:2618}, portent l'{item:11503}.",
	["Below ground"] = "Sous terre",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618} : tuez-les au passage",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} est la vallée des satyres au nord-ouest, avec {npc:10648} tout au fond. Il laisse tomber la {quest:939} ; tout satyre Jadefeu peut laisser tomber {item:11674}.\nAttention : {npc:10648} (55) se tient au fond de la vallée, entouré d'Invocateurs infernaux (53-54) : éliminez-les un par un avant de l'attirer.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "De nouveau {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Utilisez la {item:12922} au puits de lune corrompu au milieu de {area:1763}.",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Chevauchez vers le sud-est depuis {area:1763} jusqu'au {area:2479}, le camp des druides au bord de la route, dans le sud du {zone:1448}.",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Chevauchez vers le nord par la route depuis le Sanctuaire, jusqu'à l'entrée de la grotte de {area:1769} ; {npc:15395} la garde.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	-- was: ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Les furbolgs Mort-bois du {area:1762} remplissent les collines à l'ouest de la grotte. Les Vengeurs peuvent lâcher un {quest:8470}.\nAttention : les Protecteurs sont de niveau 53-54 ; ils appellent les alliés dans un rayon de 25 m quand leur vie passe sous 50 % et s'enfuient chercher de l'aide sous 15 %."
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa se tient à l'extrémité du tunnel côté {zone:1452} : gardez-la"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558} : se promène ici : cherchez à l'intérieur du cercle sur la carte",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Vers {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Suivez la route vers l'est jusqu'à {area:2255}.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "",

	-- Step 29: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} se tient à l'étage, au-dessus de {npc:7916} : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 31: The Temple Gardens
	-- {item:11682} Eridan's Vial
	["Fill {item:11682} at the moonwell inside the Temple of the Moon."] = "",

	-- Step 32: Astarii Starseeker
	-- {npc:4090} Astarii Starseeker · {quest:3378} Prayer to Elune · {zone:1427} Searing Gorge
	["{npc:4090}, in the Temple of the Moon: {quest:3378}, from the {zone:1427}"] = "",

	-- Step 33: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon."] = "",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740} : {quest:162}, depuis {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1452} Winterspring
	["For {npc:5594} in {area:976}, on the {zone:1446} and {zone:1452} guide: keep it"] = "",

	-- Step 34: Jenal
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047} waits in the {area:1658}, west of the druids' building."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil
	["{npc:9047}, in the {area:1658}: {quest:3764}"] = "",

	-- Step 36: Arch Druid Fandral Staghelm
	-- {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building; {npc:4217}, next, is lower down inside it."] = "",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "",

	-- Step 38: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, à l'étage",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} n'a pas de maître des druides",

	-- Step 39: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 40: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 41: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Depuis {area:702}, volez jusqu'à {area:1116}.",

	-- Step 43: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Bateau pour {area:1108}",

	-- Step 44: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 45: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, sur les Embruns",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, sur les Marcheurs des vagues et des profondeurs dans l'eau",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "Retournez voir {npc:14637} sur le quai.",

	-- Step 47: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "",

	-- Step 48: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "Le géant {npc:7765} est assis juste au nord-ouest du camp de {npc:7775}.",

	-- Step 49: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "La {item:11242} pousse dans un bâtiment en ruine au nord de {npc:7765} : entrez par la brèche de son mur depuis la corniche voisine.",

	-- Step 50: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Chevauchez vers l'ouest jusqu'aux ruines de Ravenwind : {npc:7774} se cache dans le petit bâtiment rond au fond. Ouvrez le coffre à côté d'elle pour obtenir {item:9189} : elle dure 15 minutes, comme la quête.",

	-- Step 51: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Ramenez {npc:7774} jusqu'à {npc:7765} au pas : elle s'éloigne, alors sonnez la cloche pour la rappeler (pas en combat), et éliminez les harpies sur le chemin avant qu'elle ne les atteigne.",

	-- Step 52: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "",

	-- Step 53: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "Se termine dans {zone:1413} : gardez-la",
	-- ["Five feathers buy a little Timbermaw reputation"] = "Cinq plumes rapportent un peu de réputation Grumegueule",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Prenez un vol de {area:1998} jusqu'au bout de la route côté sanctuaire, ou descendez-la vers le sud.",
	-- ["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Suivez la route vers le nord jusqu'au val criblé de cratères et rendez-vous à chaque cratère, en tuant les Bêtes d'entropie et les Horreurs entre eux.",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Si vous avez passé La corne de la bête ou {item:9328}, tuez des monstres ici jusqu'au niveau 52.58 pour suivre le plan de l'itinéraire.",
	-- ["Keep her alive until she is out of the cave"] = "Gardez-la en vie jusqu'à sa sortie de la grotte",
	-- ["Level 52.58"] = "Niveau 52.58",
	-- ["Level 52.69"] = "Niveau 52.69",
	-- ["Level 52.9"] = "Niveau 52.9",
	-- ["Oozes"] = "Limons",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Chevauchez vers l'est jusqu'au camp elfe de la nuit de {area:1998}.",
	-- ["Ride north out of {area:415} into {area:361}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Chevauchez vers le nord en sortant d'{area:415} jusqu'en {area:361}. {npc:11554}, le furbolg, se tient près de la route juste au sud du {area:2479}.",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Chevauchez vers le nord en quittant {area:415} pour entrer dans le {zone:1448}, jusqu'au {area:2479}, le camp des druides au bord de la route.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Chevauchez vers le nord jusqu'à {area:1769} (ou reprenez d'abord un vol pour {area:1998}) et traversez le tunnel jusqu'au {zone:1452} ; suivez la route vers l'est jusqu'à la ville gobeline de {area:2255}.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa se tient à l'extrémité du tunnel côté {zone:1452} : gardez-la",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entrez dans la grotte : {npc:11558} se tient juste à l'intérieur.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "Toujours en dessous du niveau 52.9 après les rendus du {area:2479} ? Tuez des Bêtes entropiques dans le {area:1766}, la prochaine étape au nord.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Prenez le bateau de {area:702} pour {area:442} et un vol pour {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Les Limons maudits et corrompus glissent dans les ruisseaux et les mares gangrenées autour de {area:1763} et de {area:1765} : tuez-les et utilisez les pots vides de Laris sur leurs restes.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Les furbolgs Mort-bois vivent dans le village juste au sud-ouest de {npc:11554} ; gardez les Coiffures de plumes mort-bois qu'ils laissent tomber.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Les furbolgs Mort-bois de {area:1762} occupent les collines à l'ouest de la grotte. Continuez à les tuer jusqu'à ce que l'un d'eux lâche un {quest:8470}, environ une victime sur trente, puis faites un clic droit dessus : {npc:11558}, à {area:1769}, le prend dès que les Grumegueules sont Neutres envers vous, maintenant s'ils le sont déjà, ou quand le dernier guide repasse par la grotte au niveau 58.\nAttention : les Protecteurs sont de niveau 53-54 et les Vengeurs 54-55 ; sous 50 % de vie, ils appellent les alliés à moins de 25 mètres, et sous 15 % ils s'enfuient chercher de l'aide.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Les furbolgs Mort-bois de {area:1762} occupent les collines à l'ouest de la grotte. Continuez à les tuer jusqu'à ce que l'un d'eux lâche un {quest:8470}, environ une victime sur trente, puis faites un clic droit dessus : {npc:11558}, à {area:1769}, le prend dès que les Grumegueules sont Neutres envers vous, maintenant s'ils le sont déjà, ou quand le dernier guide repasse par la grotte au niveau 58.\nAttention : les Protecteurs sont de niveau 53-54 ; sous 50 % de vie, ils appellent les alliés à moins de 25 mètres, et sous 15 % ils s'enfuient chercher de l'aide.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Les furbolgs Mort-bois de {area:1762} occupent les collines à l'ouest de la grotte. Les Vengeurs peuvent laisser tomber un {quest:8470}.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Les furbolgs Mort-bois du {area:1762} remplissent les collines à l'ouest de la grotte. Les Vengeurs peuvent lâcher un {quest:8470}.\nAttention : les Protecteurs sont de niveau 53-54 ; ils appellent les alliés dans un rayon de 25 m quand leur vie passe sous 50 % et s'enfuient chercher de l'aide sous 15 %.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Les satyres Jadefeu tiennent le vallon à l'ouest de la route, avec {npc:9454} au fond.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "La fiole se remplit à {zone:1457} : gardez-la",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "La fiole se remplit à {zone:1457} : gardez-la ; à l'intérieur",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Complétez ici jusqu'au niveau 52.69 avant les rendus de quêtes à {area:1763} : ils vous font passer au niveau 53.",
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53."] = "Complétez ici jusqu'au niveau 52.9 avant les rendus de quêtes au {area:2479} : ils vous font passer au niveau 53.",
	-- ["Trey Lightforge's remains lie beside her."] = "Les restes de Trey Lightforge gisent à côté d'elle.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Utilisez la {item:12922} au puits de lune corrompu au milieu de {area:1763}. Si vous avez libéré {npc:11018}, retournez à {area:1770} pour la succube {npc:9518} ; le cadavre de Trey Lightforge se trouve à côté d'elle.",
	-- ["grind on {npc:7109}"] = "tuez en boucle : {npc:7109}",
	-- ["grind on {npc:7153}"] = "tuez en boucle : {npc:7153}",
	-- ["grind on {npc:7155}"] = "tuez en boucle : {npc:7155}",
	-- ["grind on {npc:9878}"] = "tuez en boucle : {npc:9878}",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763} est le temple en ruine au nord du vallon.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} est le temple en ruine au nord du vallon. Certains de ses sectateurs laissent tomber une {item:13140}, environ une fois sur trente : elle ouvre la cellule de {npc:11018} à {area:1770}, la grotte du fond. Si elle tombe, dégagez le chemin de sortie avant de la libérer ; sinon, passez ses quêtes.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} est la vallée des satyres au nord-ouest, avec {npc:10648} tout au fond. Il laisse tomber la {quest:939} ; tout satyre Jadefeu peut laisser tomber {item:11674}.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, butin rare",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924} : pour {npc:11079} à {zone:1452}, gardez-la",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, à {area:1770}",
	-- ["{npc:11016}, in {area:1770}; below ground"] = "{npc:11016}, dans {area:1770} ; sous terre",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, sous terre",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557} : trente {quest:6031}, à rendre quand vous repasserez au niveau 57",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57; below ground"] = "{npc:11557} : trente {quest:6031}, à rendre quand vous repasserez au niveau 57 ; sous terre",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558} : les Grumegueule ne vous parlent qu'à partir de Neutre",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558} : les Grumegueules ne vous parlent qu'à partir de Neutre ; patrouille par ici : regardez dans le cercle sur la carte",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} attend à l'extrémité nord de {area:361}",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, sous terre",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, butin rare",
}
