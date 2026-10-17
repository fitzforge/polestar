-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Toma el barco de {area:702} a {area:442} y vuela a {area:415}.",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Cabalga al norte desde {area:415} hacia {zone:1448}. {npc:11554}, el fúrbolg, está junto al camino justo al sur de {area:2479}.",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Los fúrbolgs Muertobosque viven en la aldea justo al suroeste de {npc:11554}; guarda las plumas de penacho de Muertobosque que sueltan.",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera en el extremo norte de {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Cinco plumas dan un poco de reputación con los Fauces de Madera",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, en las ruinas justo al este de {npc:11554}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Los sátiros Fuego de Jade ocupan la cañada al oeste del camino, con {npc:9454} al fondo.",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} es el templo en ruinas al norte de la cañada. Algunos de sus sectarios sueltan una {item:13140}, más o menos una de cada treinta muertes: abre la celda de {npc:11018} en {area:1770}, la cueva del fondo. Si cae, despeja la salida antes de liberarla; si no, omite sus misiones.",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}, botín raro",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016}, en {area:1770}",
	["Keep her alive until she is out of the cave"] = "Mantenla con vida hasta que salga de la cueva",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} otra vez",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Usa {item:12922} en el pozo de la luna corrupto en medio de {area:1763}. Si liberaste a {npc:11018}, vuelve a {area:1770} por la súcubo {npc:9518}; los restos de Trey Forjaluz están a su lado.",

	-- Step 10: Oozes
	["Oozes"] = "Mocos",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Los mocos malditos y corruptos se deslizan por los arroyos y charcos viles alrededor de {area:1763} y {area:1765}: mátalos y usa los tarros de moco vacíos de Laris en sus restos.",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Sigue el camino al norte hasta la cañada de cráteres y camina hasta cada cráter, matando las bestias entrópicas y los horrores que hay entre ellos.",
	["First crater"] = "Primer cráter",
	["Second crater"] = "Segundo cráter",
	["Third crater"] = "Tercer cráter",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} es el valle de los sátiros en el noroeste, con {npc:10648} al fondo. Él suelta {quest:939}; cualquier sátiro Fuego de Jade puede soltar {item:11674}.",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Los antárboles Combadera de {area:1767}, al este de {area:2618}, llevan {item:11503}.",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "Cabalga al este hasta el campamento elfo de la noche en {area:1998}.",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Sigue el camino al norte hasta la entrada de la cueva de {area:1769}; {npc:15395} la vigila.",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Los fúrbolgs Muertobosque de {area:1762} llenan las colinas al oeste de la cueva. Los vengadores pueden soltar un {quest:8470}.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, botín raro",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa está en el extremo de {zone:1452} del túnel: guárdala",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entra en la cueva: {npc:11558} y {npc:11557} están justo dentro.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: los Fauces de Madera solo te hablan a partir de Neutral",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: treinta {quest:6031}, se entregan cuando vuelvas a pasar a nivel 57",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Vuela de {area:1998} al extremo del camino del Santuario, o cabalga al sur por él.",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "El vial se llena en {zone:1457}: guárdala",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Termina en {zone:1413}: guárdala",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Cabalga al norte hasta {area:1769} (o vuela antes de vuelta a {area:1998}) y cruza el túnel hacia {zone:1452}; sigue el camino al este hasta el pueblo goblin de {area:2255}.",
}
