-- Spanish (Spain) (esES): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} es tu base en esta guía: la piedra de hogar te trae de vuelta aquí dos veces. Todos están alrededor de la plaza del pueblo.",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "El cartel de {object:1763} junto a la posada",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "El cartel de {quest:567}: sus objetivos aparecen por el camino",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Llena {item:7768} en {object:107045} junto a la posada",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Solo si Gallywix cayó en {zone:1413} (Misión: posible, pero no probable): {npc:2391} está en {area:272}. Espera a su lado mientras prepara la cura y recoge tu recompensa: Venenos.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Venenos",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "¿Aún no has acabado con Gallywix? La guía de clase Venenos (Horda) repite la cadena desde Shenthul, con un grupo para Gallywix.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Osos, trepamusgos y leones",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "Al oeste de Molino Tarren, osos grises, trepamusgos del bosque y leones monteses hambrientos recorren las colinas de bajada a las granjas. Los trepamusgos sueltan {item:3477} rara vez; solo necesitas uno.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Las granjas al este del pueblo de {area:287}. {npc:232} trabaja el campo junto a la granja del norte y {npc:2403} el que está más al sureste; hay mozos de labranza y granjeros por todas partes. {npc:2451} cuida el campo al sur de las granjas.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}, junto al Boticario Lydon",

	-- Step 6: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} es el perro de {npc:232}, en la granja del norte de {area:286}.",

	-- Step 7: Peasants and skulls
	["Peasants and skulls"] = "Campesinos y cráneos",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Los campesinos trabajan los campos al sur de las granjas. Todos los humanos de {area:287} sueltan cráneos; los campesinos son los que más.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: los Campesinos de los campos",

	-- Step 8: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: órdenes para {npc:270438}, de camino al Castillo de Durnholde",

	-- Step 9: Syndicate camps
	["Syndicate camps"] = "Campamentos del Sindicato",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Desde {area:272}, ve al sureste por las colinas de camino a {area:275}. Pícaros y vigilantes del Sindicato ocupan los campamentos del camino.",

	-- Step 10: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull y {npc:2238} están encadenados en los edificios del patio de {area:275}; abre ambos cerrojos.",
	["Drull's ball and chain"] = "La bola y cadena de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "La bola y cadena de {npc:2238}",

	-- Step 11: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se esconde en la ladera sobre {area:290}, al sur del Castillo de Durnholde, de bajada hacia las flores.",

	-- Step 12: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "Al suroeste del Castillo de Durnholde, {item:3502} crecen en las laderas sobre el río.",

	-- Step 13: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, en {zone:1458}",

	-- Step 14: The smithy
	["The smithy"] = "La herrería",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "La herrería está en medio del pueblo de {area:287}. {npc:2404} y sus aprendices trabajan en la forja; {object:1736} está apilado al lado. {npc:2449} pasea por la calle al norte.",

	-- Step 16: Town hall
	["Town hall"] = "Ayuntamiento",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "El ayuntamiento está en el lado oeste de {area:287}. {npc:2335} (30) y {npc:2448} están dentro con el Registro de Trabalomas; la Proclamación de Trabalomas está colgada al lado. Los consejeros recorren el pueblo.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288} está al sur del pueblo de {area:287}. Los mineros trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están al fondo.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, en el Apothecarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Guárdala: la costa de {area:287}, más adelante en la ruta",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Toma el zepelín desde las torres a las afueras de {zone:1458} hasta {zone:1454} y entrena antes de seguir volando.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Desde {zone:1454} (zepelín desde las torres a las afueras de {zone:1458}), vuela a {area:1638} y entrena en {area:1639}; luego sigue volando a {area:378}.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Desde {zone:1454} (zepelín desde las torres a las afueras de {zone:1458}), vuela a {area:378}.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La choza de {npc:5899} está en la cresta sobre el abrevadero de los jabaespines, al sur de {area:378}, de camino a {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: el odre rojo de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: el odre azul se llena en {zone:1440}, en la siguiente guía",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Sigue el camino hacia el sur hasta la excavación enana de {area:359}. {npc:3421} se esconde en el borde sur de la excavación; {object:3646} está en el fondo.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:485} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "Al suroeste de Bael Modan, {npc:12576} espera en lo alto de {area:485}.",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Usa la Piedra de hogar para ir a {area:378} y vuela a {area:392}. {quest:874} acampa en la orilla al norte de {area:392}.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un gran trillanodonte, nada en las aguas poco profundas de {area:391}, al este de {npc:3388}.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, junto a los muelles de {area:392}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "¿Aún no has acabado con Gallywix? La guía de clase {spell:2842} (Horda) repite la cadena desde Shenthul, con un grupo para Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Solo si Gallywix cayó en {zone:1413} (Misión: posible, pero no probable): {npc:2391} está en {area:272}. Espera a su lado mientras prepara la cura y recoge tu recompensa: Venenos.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Solo si Gallywix cayó en {zone:1413} (Misión: posible, pero no probable): {npc:2391} está en {area:272}. Espera a su lado mientras prepara la cura y recoge tu recompensa: {spell:2842}.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "La herrería está en medio del pueblo de {area:287}. {npc:2404} y sus aprendices trabajan en la forja; {item:3564} está apilado al lado. {npc:2449} pasea por la calle al norte.",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Llegas vinculado a la posada de {area:272}. Todos están alrededor de la plaza del pueblo.",
	-- ["{npc:2055}, in the {object:36072}"] = "{npc:2055}, en {object:36072}",
}
