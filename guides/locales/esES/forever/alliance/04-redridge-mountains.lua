-- Spanish (Spain) (esES): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 2: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {area:12} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "",
	["Level 18 and 20 spells"] = "Hechizos de nivel 18 y 20",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: la carta de Thundris desde {area:442}",
	-- {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 4: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 5: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "Misiones de clase de {zone:1453}",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} está en el IV:7 de {object:2100}; {npc:6122}, en el sótano de {object:2164}, en {object:2101}; {npc:376}, en la catedral.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: la recoge {npc:7024} en {zone:1436}, al final de {zone:1431}",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: la recoge {npc:6244} en {zone:1413}, más adelante",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: la recoge {npc:11406} en {zone:1455}, más adelante",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: la recoge {npc:258785} en {zone:1455}, más adelante",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: la recoge {npc:11401} en {zone:1457}, más adelante",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y vuelve en el tranvía.",

	-- Step 8: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: la {object:177790}",

	-- Step 10: Back to Elwynn Forest
	-- {area:12} Elwynn Forest
	["Back to {area:12}"] = "",

	-- Step 13: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "",

	-- Step 15: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "El camino desde Bosque de Elwynn entra en Montañas Crestagrana por {area:1002}. {npc:464} está donde se cruzan los caminos a Montañas Crestagrana y {zone:1431}.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "",

	-- Step 16: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Sigue el camino por la orilla sur de {area:68} hasta la maestra de grifos. {npc:1070} y {npc:903} están junto al camino, a su lado.",

	-- Step 17: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Cruza el largo puente hacia el norte hasta el pueblo. {npc:341} y {npc:382} están en el extremo norte del puente; {npc:900}, en el ayuntamiento; {npc:381} y {npc:266}, en los muelles; {npc:343}, en la posada; {npc:342}, en su huerto del extremo oeste.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks; upstairs"] = "",
	["Inside"] = "",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "",

	-- Step 18: Spotted Sunfish on the way
	-- {item:1467} Spotted Sunfish
	["{item:1467} on the way"] = "",

	-- Step 19: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nada al este desde el puente hasta {area:68}; el cofre está en el fondo del lago.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "",

	-- Step 21: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Vándalos de Crestagrana",

	-- Step 26: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341}: después de {quest:89}",

	-- Step 27: Lake Everstill: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}: kill these as you meet them"] = "",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Greater Tarantulas = {npc:505} Greater Tarantula
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "",

	-- Step 28: Blackrock camps
	["Blackrock camps"] = "",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "",

	-- Step 29: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Vuelve a {area:69}",

	-- Step 30: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Sal de {area:69} hacia el norte, sube por {area:95} hasta {area:997}. Los Campeones Roca Negra acampan en el valle.",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 31: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se esconde en el extremo norte del valle, junto a la frontera de {zone:1428}. Escóltalo hasta {area:69}; los orcos Roca Negra te tienden emboscadas por el camino.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 32: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, junto a los grifos al sur del puente",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Ahora toca {zone:1431}: sigue el camino al oeste hasta {area:1002} y luego al sur hasta {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Panzallena",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "Al este, pasado el molino, cruza el río. Los gnols Pielsombra llenan el valle; {npc:703} (26, muy por encima de ti) los dirige en el extremo norte: acaba primero con su escolta y lucha contra él con la salud al máximo. No entres en {area:2099}, al sur: sus orcos son élite.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Vuela a {area:108} y cabalga al noroeste hasta la costa: la {object:177790} está en el fondo del mar frente a la orilla. Después cabalga al este por el camino a través de Bosque de Elwynn hasta Montañas Crestagrana.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Para {npc:3649}, a la vuelta a {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnols hacia {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Las Tarántulas mayores recorren las laderas alrededor del molino al noreste del lago; los Renegados Roca Negra ocupan el propio molino.",
	-- ["Lake murlocs"] = "Múrlocs del lago",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Los Comecarnes múrloc y los llamamareas ocupan la orilla sur al este del puente. Cualquiera de ellos puede llevar un {item:1467} o una aleta.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Los Bastardos de Crestagrana y otros gnols ocupan las colinas al este de {area:1002}, al norte del camino; los Vándalos de Crestagrana merodean entre ellos y los furtivos acampan al sur del camino. Dire Condors y Grandes dentosangre recorren las mismas colinas.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "El cartel de Se busca junto a la posada: {npc:703}, en {area:1000}",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "El barco de {area:442} atraca en {area:17203}. Sube a la ciudad para entrenar y ver a {npc:1646}; después sal por la puerta principal y sigue el camino hacia el este por {zone:1429}.",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: cualquier gnol Pielsombra",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: cualquier orco Roca Negra",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: los Renegados Roca Negra del molino",
	-- ["{npc:266}, by the docks"] = "{npc:266}, junto a los muelles",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, en el ayuntamiento",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (nivel 24) hoza en el corral justo al oeste de {area:69}. Apártalo de los demás jabalíes y lucha con la salud al máximo.",
}
