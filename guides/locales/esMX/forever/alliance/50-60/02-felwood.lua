-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
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
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, en las ruinas justo al este de {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, adentro",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {quest:86577}, de los osos y lobos que encuentres en {zone:1448}",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554}, el fúrbolg, está junto al camino justo al sur de {area:2479}.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Los fúrbolgs Muertobosque viven en la aldea justo al suroeste de {npc:11554}; guarda las plumas de penacho de Muertobosque que sueltan."
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera en el extremo norte de {zone:1448}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Los sátiros Fuego de Jade ocupan la cañada al oeste del camino, con {npc:9454} al fondo.\nCuidado: Los acechasombras Fuego de Jade (nivel 51-52) usan Sigilo y {spell:7992} y van ocultos, así que a menudo se suman a las peleas sin que los llames.\nLos mocos malditos se deslizan por los arroyos de la cañada: mátalos y usa el tarro vacío para mocos de Laris sobre sus restos.",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Cuidado: {npc:9454} (54) está al fondo de {area:2481}, alrededor de 32.2,67.1, con acechasombras a su alrededor: elimínalos de uno en uno y luego atráelo solo con la salud llena.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: los mocos corruptos se deslizan por las pozas viles de {area:1763}",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Órganos putrefactos: mátalos a medida que los encuentres",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Los osos Zarpira y los lobos Zarpavil de {zone:1448} llevan los órganos putrefactos que quiere {npc:10920}: los osos y lobos (47-48) del sur y los magulladores y carroñeros (49-50) a lo largo del camino al norte de {area:1763}. Mátalos mientras cabalgas entre las paradas.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Sigue el camino al norte hasta la cañada de cráteres y camina hasta cada cráter, matando las bestias entrópicas y los horrores que hay entre ellos.\nCuidado: un {npc:7136} (53, élite) está entre los cráteres: rodéalo.",
	["First crater"] = "Primer cráter",
	["Second crater"] = "Segundo cráter",
	["Third crater"] = "Tercer cráter",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Los antárboles Combadera de {area:1767}, al este de {area:2618}, llevan {item:11503}.",
	["Below ground"] = "Bajo tierra",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: mata a estos según te los encuentres",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} es el valle de los sátiros en el noroeste, con {npc:10648} al fondo. Él suelta {quest:939}; cualquier sátiro Fuego de Jade puede soltar {item:11674}.\nCuidado: {npc:10648} (55) está al fondo del valle con invocadores infernales (53-54) a su alrededor: elimínalos de uno en uno antes de atraerlo.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} otra vez",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Usa {item:12922} en el pozo de la luna corrupto del centro de {area:1763}.",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Cabalga al sureste desde {area:1763} hasta {area:2479}, el campamento de los druidas junto al camino en el sur de {zone:1448}.",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Cabalga al norte por el camino desde el Santuario, hasta llegar a la entrada de la cueva de {area:1769}; {npc:15395} la vigila.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa está en el extremo de {zone:1452} del túnel: guárdala"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: recorre esta zona: busca dentro del círculo del mapa",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Hacia {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} está justo en la salida a {zone:1452} del túnel de {area:1769}, por donde sales.",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Cabalga al este por el camino hasta {area:2255}.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Vuela a {area:702}",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "",

	-- Step 29: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} está arriba, encima de {npc:7916}: sube por adentro, la flecha no distingue los pisos.",

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
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, desde {area:976}",
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
	["{npc:4217}, upstairs"] = "{npc:4217}, arriba",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} no tiene instructor de druidas",

	-- Step 39: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 40: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 41: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Desde {area:702}, vuela a {area:1116}.",

	-- Step 43: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Barco a {area:1108}",

	-- Step 44: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 45: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: mata a estos según te los encuentres",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, de los Rocíos del mar",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, en los Zancaolas y Zancaprofundas del agua",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "Regresa con {npc:14637} en el muelle.",

	-- Step 47: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "",

	-- Step 48: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "El gigante {npc:7765} está sentado justo al noroeste del campamento de {npc:7775}.",

	-- Step 49: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "La {item:11242} crece dentro de un edificio en ruinas al norte de {npc:7765}: entra por la brecha de su muro desde la cornisa de al lado.",

	-- Step 50: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Cabalga al oeste hacia las Ruinas de Viento Cuervo: {npc:7774} se esconde en el pequeño edificio redondo del fondo. Abre el cofre junto a ella para obtener {item:9189}: dura 15 minutos, igual que la misión.",

	-- Step 51: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Lleva a {npc:7774} de vuelta con {npc:7765} al paso: se aleja, así que toca la campana para llamarla (no en combate), y despeja las arpías del camino antes de que llegue a ellas.",

	-- Step 52: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "",

	-- Step 53: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "Termina en {zone:1413}: guárdala",
	-- ["Five feathers buy a little Timbermaw reputation"] = "Cinco plumas dan un poco de reputación con los Fauces de Madera",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Vuela de {area:1998} al extremo del camino del Santuario, o cabalga al sur por él.",
	-- ["Fly to {area:415}"] = "Vuela a {area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Sigue el camino al norte hasta la cañada de cráteres y camina hasta cada cráter, matando las bestias entrópicas y los horrores que hay entre ellos.",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Si te saltaste El cuerno de la bestia o {item:9328}, mata enemigos aquí hasta el nivel 52.58 para seguir el plan de la ruta.",
	-- ["Keep her alive until she is out of the cave"] = "Mantenla con vida hasta que salga de la cueva",
	-- ["Level 52.58"] = "Nivel 52.58",
	-- ["Level 52.69"] = "Nivel 52.69",
	-- ["Level 52.9"] = "Nivel 52.9",
	-- ["Oozes"] = "Mocos",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Cabalga al este hasta el campamento elfo de la noche en {area:1998}.",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Cabalga al norte saliendo de {area:415} hasta {zone:1448}, a {area:2479}, el campamento de los druidas junto al camino.",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Cabalga al norte desde {area:415} hacia {zone:1448}. {npc:11554}, el fúrbolg, está junto al camino justo al sur de {area:2479}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Cabalga al norte hasta {area:1769} (o vuela antes de vuelta a {area:1998}) y cruza el túnel hacia {zone:1452}; sigue el camino al este hasta el pueblo goblin de {area:2255}.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa está en el extremo de {zone:1452} del túnel: guárdala",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entra en la cueva: {npc:11558} y {npc:11557} están justo dentro.",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entra a la cueva: {npc:11558} está justo en la entrada.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "¿Todavía no llegas al nivel 52.9 después de las entregas de {area:2479}? Sube de nivel con las bestias entrópicas en {area:1766}, la siguiente parada al norte.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Toma el barco de {area:702} a {area:442} y vuela a {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Los mocos malditos y corruptos se deslizan por los arroyos y charcos viles alrededor de {area:1763} y {area:1765}: mátalos y usa los tarros de moco vacíos de Laris en sus restos.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Los fúrbolgs Muertobosque viven en la aldea justo al suroeste de {npc:11554}; guarda las plumas de penacho de Muertobosque que sueltan.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Sigue matándolos hasta que uno suelte un {quest:8470}, más o menos uno de cada treinta, luego haz clic derecho en él: {npc:11558}, en {area:1769}, lo acepta cuando los Fauces de Madera te sean neutrales, ahora si ya lo son, o cuando la última guía vuelva a pasar por la cueva a nivel 58.\nCuidado: Los vigías del cubil son de nivel 53-54 y los vengadores de 54-55; piden ayuda a los aliados a menos de 25 m cuando bajan del 50% de salud y huyen en busca de ayuda por debajo del 15%.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Sigue matándolos hasta que uno suelte un {quest:8470}, más o menos uno de cada treinta, luego haz clic derecho en él: {npc:11558}, en {area:1769}, lo acepta cuando los Fauces de Madera te sean neutrales, ahora si ya lo son, o cuando la última guía vuelva a pasar por la cueva a nivel 58.\nCuidado: Los vigías del cubil son de nivel 53-54; piden ayuda a los aliados a menos de 25 m cuando bajan del 50% de salud y huyen en busca de ayuda por debajo del 15%.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Los vengadores pueden soltar un {quest:8470}.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Los sátiros Fuego de Jade ocupan la cañada al oeste del camino, con {npc:9454} al fondo.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "El vial se llena en {zone:1457}: guárdala",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "El vial se llena en {zone:1457}: guárdalo; adentro",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Completa aquí hasta el nivel 52.69 antes de las entregas de {area:1763}: te llevan al nivel 53.",
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Completa aquí hasta el nivel 52.9 antes de las entregas de {area:2479}: te llevan al nivel 53. O, con un grupo, haz en su lugar la mazmorra {area:1417} o la mazmorra {area:2100}.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Usa {item:12922} en el pozo de la luna corrupto en medio de {area:1763}. Si liberaste a {npc:11018}, vuelve a {area:1770} por la súcubo {npc:9518}; los restos de Trey Forjaluz están a su lado.",
	-- ["grind on {npc:7109}"] = "farmea {npc:7109}",
	-- ["grind on {npc:7153}"] = "sube de nivel con {npc:7153}",
	-- ["grind on {npc:7155}"] = "sube de nivel con {npc:7155}",
	-- ["grind on {npc:9878}"] = "sube de nivel con {npc:9878}",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763} es el templo en ruinas al norte de la cañada.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} es el templo en ruinas al norte de la cañada. Algunos de sus sectarios sueltan una {item:13140}, más o menos una de cada treinta muertes: abre la celda de {npc:11018} en {area:1770}, la cueva del fondo. Si cae, despeja la salida antes de liberarla; si no, omite sus misiones.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} es el valle de los sátiros en el noroeste, con {npc:10648} al fondo. Él suelta {quest:939}; cualquier sátiro Fuego de Jade puede soltar {item:11674}.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, botín raro",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: para {npc:11079} en {zone:1452}, guárdala",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, en {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: treinta {quest:6031}, se entregan cuando vuelvas a pasar a nivel 57",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: los Fauces de Madera solo te hablan a partir de Neutral",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: los Fauces de Madera solo te hablan desde Neutral; da vueltas por aquí: búscala dentro del círculo del mapa",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} espera en el extremo norte de {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, botín raro",
}
