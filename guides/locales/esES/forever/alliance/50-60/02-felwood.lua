-- Spanish (Spain) (esES): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Vuela a {area:415}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 2: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "El {area:2479}",

	-- Step 3: The Emerald Sanctuary
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Cabalga al norte saliendo de {area:415} hasta {zone:1448}, a {area:2479}, el campamento de los druidas junto al camino.",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, en las ruinas justo al este de {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, dentro",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {quest:86577}, de los osos y lobos que encuentres en {zone:1448}",

	-- Step 4: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554}, el fúrbolg, está junto al camino, justo al sur del {area:2479}.",

	-- Step 5: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Los fúrbolgs Muertobosque viven en el poblado justo al suroeste de {npc:11554}; guarda las plumas de penacho Muertobosque que sueltan.",

	-- Step 6: Level 52.58
	["Level 52.58"] = "Nivel 52.58",
	-- {item:9328} Super Snapper FX
	["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Si te saltaste El cuerno de la bestia o {item:9328}, mata enemigos aquí hasta el nivel 52.58 para seguir el plan de la ruta.",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "mata {npc:7153}",

	-- Step 7: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera en el extremo norte de {zone:1448}",

	-- Step 8: Level 52.69
	["Level 52.69"] = "Nivel 52.69",
	-- {area:1763} Jaedenar
	["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Completa aquí hasta el nivel 52.69 antes de las entregas de {area:1763}: te llevan al nivel 53.",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "mata {npc:7155}",

	-- Step 9: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Los sátiros Fuego de Jade ocupan la cañada al oeste del camino, con {npc:9454} al fondo.\nCuidado: Los acechasombras Fuego de Jade (nivel 51-52) usan Sigilo y {spell:7992} y van ocultos, así que a menudo se suman a las peleas sin que los llames.\nLos mocos malditos se deslizan por los arroyos de la cañada: mátalos y usa el tarro vacío para mocos de Laris sobre sus restos.",
	-- {npc:7109} Jadefire Felsworn
	["grind on {npc:7109}"] = "mata {npc:7109}",

	-- Step 10: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Cuidado: {npc:9454} (54) está al fondo de {area:2481}, hacia 32.2,67.1, rodeado de acechasombras: elimínalos uno a uno y luego atráelo solo con la salud llena.",

	-- Step 11: Jaedenar
	-- {area:1763} Jaedenar
	["{area:1763} is the ruined temple north of the glen."] = "{area:1763} es el templo en ruinas al norte de la cañada.",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: los mocos corruptos se deslizan por las pozas viles de {area:1763}",

	-- Step 12: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Órganos putrefactos: mátalos según los encuentres",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Los osos Zarpira y los lobos Zarpavil de {zone:1448} llevan los órganos putrefactos que quiere {npc:10920}: los osos y lobos (47-48) del sur y los vapuleadores y carroñeros (49-50) junto al camino al norte de {area:1763}. Mátalos mientras cabalgas entre paradas.",

	-- Step 14: Level 52.9
	["Level 52.9"] = "Nivel 52.9",
	-- {area:2479} Emerald Sanctuary · {area:1766} Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "¿Aún te falta para el nivel 52.9 tras las entregas de {area:2479}? Sube con las Bestias entrópicas de {area:1766}, la siguiente parada al norte.",
	-- {npc:9878} Entropic Beast
	["grind on {npc:9878}"] = "mata {npc:9878}",

	-- Step 15: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Sigue el camino al norte hasta el valle de cráteres y ve a cada cráter, matando las bestias entrópicas y los horrores entre ellos.\nCuidado: un {npc:7136} (53, élite) está entre los cráteres: rodéalo.",
	["First crater"] = "Primer cráter",
	["Second crater"] = "Segundo cráter",
	["Third crater"] = "Tercer cráter",

	-- Step 16: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Los antárboles Combadera de {area:1767}, al este de {area:2618}, llevan el {item:11503}.",
	["Below ground"] = "Bajo tierra",

	-- Step 17: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: mátalos según te los encuentres",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} es el valle de sátiros del noroeste, con {npc:10648} al fondo. Él suelta la {quest:939}; cualquier sátiro Fuego de Jade puede soltar {item:11674}.\nCuidado: {npc:10648} (55) está al fondo del valle rodeado de clamainfiernos (53-54): elimínalos uno a uno antes de atraerlo.",

	-- Step 18: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} otra vez",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Usa {item:12922} en el pozo de la luna corrupto del centro de {area:1763}.",

	-- Step 19: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Cabalga al sureste desde {area:1763} hasta {area:2479}, el campamento de los druidas junto al camino en el sur de {zone:1448}.",

	-- Step 20: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it; inside"] = "El vial se llena en {zone:1457}: guárdalo; dentro",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Termina en {zone:1413}: guárdala",
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {zone:1452} Winterspring
	["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: para {npc:11079} en {zone:1452}, guárdala",

	-- Step 21: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Cabalga al norte por el camino desde el Santuario, hasta llegar a la entrada de la cueva de {area:1769}; {npc:15395} la vigila.",

	-- Step 22: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Sigue matándolos hasta que uno suelte un {quest:8470}, aprox. uno de cada treinta, y luego haz clic derecho sobre él: {npc:11558} en {area:1769} lo acepta cuando los Fauces de Madera te sean neutrales, ahora si ya lo son, o cuando la última guía vuelva a pasar por la cueva a nivel 58.\nCuidado: los vigías de la guarida son de nivel 53-54 y los vengadores 54-55; llaman a los aliados cercanos en 25 m al bajar del 50% de salud y huyen a por ayuda por debajo del 15%.",

	-- Step 23: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa está en la salida de {zone:1452} del túnel: guárdala",

	-- Step 25: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "Entra en la cueva: {npc:11558} está justo dentro.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: los Fauces de Madera solo te hablan desde Neutral; recorre esta zona: busca dentro del círculo del mapa",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Five feathers buy a little Timbermaw reputation"] = "Cinco plumas dan un poco de reputación con los Fauces de Madera",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Vuela desde {area:1998} al extremo del camino del Santuario, o cabalga al sur por él.",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Sigue el camino al norte hasta el valle de cráteres y ve a cada cráter, matando las bestias entrópicas y los horrores entre ellos.",
	-- ["Keep her alive until she is out of the cave"] = "Mantenla con vida hasta que salga de la cueva",
	-- ["Oozes"] = "Mocos",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Cabalga al este hasta el campamento elfo de la noche de {area:1998}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Cabalga al norte hasta {area:1769} (o vuela antes a {area:1998}) y cruza el túnel hasta {zone:1452}; sigue el camino al este hasta el pueblo goblin de {area:2255}.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Toma el barco de {area:702} a {area:442} y vuela a {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Los mocos malditos y corruptos se deslizan por los arroyos y charcas viles alrededor de {area:1763} y {area:1765}: mátalos y usa las jarras de moco vacías de Laris en sus restos.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Los vengadores pueden soltar un {quest:8470}.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Los sátiros Fuego de Jade ocupan el claro al oeste del camino, con {npc:9454} al fondo.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Usa la {item:12922} en el pozo de la luna corrupto del centro de {area:1763}. Si liberaste a {npc:11018}, vuelve a {area:1770} a por la súcubo {npc:9518}; los restos de Trey Lightforge yacen a su lado.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} es el templo en ruinas al norte del claro. Algunos de sus cultores sueltan una {item:13140}, más o menos una de cada treinta muertes: abre la celda de {npc:11018} en {area:1770}, la cueva del fondo. Si cae, despeja la salida antes de liberarla; si no, sáltate sus misiones.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} es el valle de sátiros del noroeste, con {npc:10648} al fondo. Él suelta la {quest:939}; cualquier sátiro Fuego de Jade puede soltar {item:11674}.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, botín poco común",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, en {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: treinta {quest:6031}, que entregas cuando vuelvas a pasar a nivel 57",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} espera en el extremo norte de {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, botín poco común",
}
