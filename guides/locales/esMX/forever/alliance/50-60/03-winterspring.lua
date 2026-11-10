-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 4: Everlook's inn
	-- {area:2255} Everlook
	["{area:2255}'s inn"] = "La posada de {area:2255}",
	-- {area:144} Thelsamar · {zone:1425} Hinterlands · {zone:1452} Winterspring · {area:2255} Everlook
	["Your Hearthstone is not set at {area:144} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Tu Piedra de hogar no está vinculada a {area:144} (la guía de {zone:1425} te vincula allí a nivel 47, y esta guía sale de {zone:1452} a través de allí): vincúlate en {area:2255}, para los viajes de vuelta al pueblo.",

	-- Step 5: Everlook
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}; inside"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "",
	-- {npc:11754} Meggi Peppinrocker · {area:2255} Everlook
	["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "",

	-- Step 7: Ice Thistle Hills: kill these as you meet them
	-- {area:2247} Ice Thistle Hills
	["{area:2247}: kill these as you meet them"] = "",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Los yetis Cardo Nevado viven en las colinas al sur de {area:2244}, y las Quimeras Viento Gélido ({npc:7448}), en el valle hacia {area:2255}.",

	-- Step 8: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Las ruinas rodean el lago helado al sur de {area:2253}. Recoge los cuatro fragmentos de reliquia que hay en las ruinas y las Plumas Lunadón ({item:12383}) del suelo, donde rondan los lechúcicos.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Sigue el camino al oeste hasta el campamento de {npc:9298}, junto a las aguas termales.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guárdalo: Gregan prepara el elixir más adelante en {zone:1444}",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {item:14047} Runecloth · {zone:1452} Winterspring · {area:1584} Blackrock Depths
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}. Or, with a group, run the {area:1584} dungeon instead."] = "",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "",

	-- Step 11: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "La Caldera de Muertobosque en {zone:1448}: guárdalo",

	-- Step 12: Level 55.05
	["Level 55.05"] = "",
	-- {area:2255} Everlook · {area:2246} Frostfire Hot Springs · {area:1769} Timbermaw Hold · {quest:8471} Winterfall Ritual Totem · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",

	-- Step 13: Winterfall Ritual Totem
	["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Para Kernda en {area:1769}: guárdalo",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "La aldea de los fúrbolgs Nevada está al este de {area:2255}: Chamanes (56-57), Vigías del cubil (55-56) y Ursas (57-58), todos por encima de ti. Mata primero a los Chamanes, que curan, y atrae desde el borde. {npc:10738}, en la cueva del fondo, es élite: no entres.",

	-- Step 16: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos prístinos de yeti ({item:12367})",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "",

	-- Step 17: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Sobre {npc:10978}, junto a la posada",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} y {npc:10977} vienen después",
	-- {npc:10978} Legacki · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10978} with {item:12928}"] = "Asusta a {npc:10978} con {item:12928}",

	-- Step 18: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "A {area:2101}",
	-- {area:144} Thelsamar · {area:3197} Chillwind Camp · {area:2255} Everlook
	["Your Hearthstone is still set at {area:144}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Tu Piedra de hogar sigue vinculada a {area:144}: desde allí, el grifo a {area:3197} es unos diez minutos más rápido que el vuelo de {area:2255} a Isla Theramore y el barco.",

	-- Step 19: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Vuela a {area:3197}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 20: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Isla Theramore",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 21: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 22: Fly to Chillwind Camp
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 23: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Puricorazón, Dumah, Puño de Valor y MacDonnell están en el centro del campamento, junto al maestro de vuelo.",
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen después, en {area:2627}",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:200} Dalson's Tears
	["{npc:11053}: the cauldron is at {area:200}, keep it"] = "",

	-- Step 24: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "",
	["Inside"] = "",

	-- Step 25: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 27: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Sigue el camino del sur al este hacia {zone:1423}; las ruinas de {area:2262} están al sur de él. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",

	-- Step 28: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "La muñeca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Las tres piezas de la muñeca están en las casas en ruinas de {area:2262}; recoger una puede atraer fantasmas. Combínalas para formar la muñeca.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 29: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422}: guárdala",

	-- Step 30: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Sigue el camino al este a través de la zona hasta la capilla.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "",

	-- Step 31: Corin's Crossing
	-- {area:2264} Corin's Crossing · {npc:10411} Eye of Naxxramas
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera Espíritus de Villa Darrow ({npc:11064}): habla con ellos",

	-- Step 32: The Undercroft
	-- {area:2261} The Undercroft
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr es élite: se recomienda ir en grupo. Espera en el fondo de {area:2261}, la cripta del suroeste de la zona.",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "",

	-- Step 33: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "La siguiente guía empieza aquí y vuela a {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "De vuelta a las colinas: solo las Matriarcas Cardo Nevado ({npc:7459}) y los Patriarcas llevan los cuernos. Sigue matando yetis hasta el nivel 54: antes de eso, las misiones de lechúcicos de Harlo están en rojo.",
	-- ["Fly to {area:271}"] = "Vuela a {area:271}",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Sigue el camino del sur al este hacia {area:139}; las ruinas de {area:2262} están al sur de él. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Sigue las indicaciones de {npc:9298} hasta la entrada de {area:2256}, pasando a los gigantes Machacahielo: pásalos de uno en uno.",
	-- ["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Recoge los suministros alrededor de la carreta y recupera el amuleto de {npc:10301} de las lechubestias cercanas.",
	-- ["Pristine Yeti Horns"] = "Cuernos prístinos de yeti ({item:12367})",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas, y su libro de recibos está en la posada en ruinas cercana.",
	-- ["Ride north-west back to the village."] = "Cabalga al noroeste de vuelta a la aldea.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cabalga al sureste valle abajo hasta la caja dañada de {npc:10301} en la nieve, en {area:2245}, con su carreta destrozada justo al este.",
	-- ["Ride west along the road to the night elf village."] = "Cabalga al oeste por el camino hasta la aldea de los elfos de la noche.",
	-- ["Ride west along the road to {npc:10301}."] = "Cabalga al oeste por el camino hasta {npc:10301}.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "¿Te falta para el nivel 54 después de los yetis? Hacer {area:1417} (50-54) en grupo en vez de matar bichos te lleva ahí más rápido. Luego vuelve a {area:2255}.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "La Plaga alrededor de {area:2264}, al oeste de la capilla, suelta ambos tipos de Piedra de la Plaga; de ellos surgen Espíritus de Villa Darrow ({npc:11064}): habla con cada uno para liberarlo.",
	-- ["The Winterfall camp"] = "El campamento Nevada",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "El campamento Nevada del oeste está en las colinas entre {npc:11556} y {npc:9298}. Cualquier fúrbolg de aquí puede soltar un {item:12771} (uno de cada diez, más o menos) y, rara vez, un {quest:8471}: haz clic derecho en lo que suelte. Guarda el {quest:6031} que sueltan los fúrbolgs para Meilosh.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Los fúrbolgs Nevada del oeste sueltan las cuentas.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atraviesa {area:1769} hasta {zone:1448} y sigue volando hacia los Reinos del Este ({area:442}, el barco a {area:150}). Vuela a {area:271} y cabalga al norte por el camino a través de Alterac hasta {area:3197}.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "mata {npc:7460} en {area:2247}, {zone:1452}",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, botín poco común",
	-- ["{npc:10301}'s camp"] = "El campamento de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Los suministros de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarda ambas para las Tierras de la Peste",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} es un élite de nivel 54",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} vigila la entrada de {area:1769}, al noroeste de {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guárdala para {area:2262}",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} es élite: se recomienda ir en grupo. Espera en el fondo de {area:2261}, la cripta del suroeste de la zona.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, en {area:28}: guárdala",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh más adelante",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, botín poco común",
}
