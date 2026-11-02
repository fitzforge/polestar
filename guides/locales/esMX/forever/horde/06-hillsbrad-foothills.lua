-- Spanish (Latin America) (esMX): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} es tu base en esta guía: la piedra de hogar te trae de vuelta aquí dos veces. Todos están alrededor de la plaza del pueblo.",
	["Inside"] = "",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Llena el {item:7768} en el {object:107045} junto a la posada",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",
	-- {object:556670} WANTED (no name in this language: may be words)
	["The {object:556670} poster by the inn"] = "",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way; inside"] = "",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Venenos",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Osos, trepamusgos y leones",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "Al oeste de Molino Tarren, Osos grises ({npc:2351}), Trepamusgos del bosque ({npc:2350}) y Leones de montaña famélicos ({npc:2384}) recorren las colinas camino a las granjas. Los trepamusgos sueltan {item:3477} rara vez; solo necesitas uno.",

	-- Step 4: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "",

	-- Step 5: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "",

	-- Step 6: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "",

	-- Step 7: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Las granjas al este del pueblo de {area:287}. {npc:232} trabaja el campo junto a la granja del norte; {npc:2403}, el que está más al sureste; hay Mozos de labranza y Granjeros por todas partes. {npc:2451} cuida el campo al sur de las granjas.",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "",

	-- Step 9: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} es el perro de {npc:232}, en la granja del norte de {area:286}.",

	-- Step 10: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: los campesinos de los campos",

	-- Step 11: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 12: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: órdenes para {npc:270438}, camino al Castillo de Durnholde",

	-- Step 13: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "",
	["Drull's ball and chain"] = "Bola y cadena de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Bola y cadena de {npc:2238}",

	-- Step 14: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "Al suroeste del Castillo de Durnholde, las {item:3502} crecen en las laderas sobre el río.",

	-- Step 15: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se esconde en la ladera sobre {area:290}, al sur del Castillo de Durnholde, camino abajo hacia las flores.",

	-- Step 16: The smithy
	["The smithy"] = "La herrería",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "La herrería está en el centro del pueblo de {area:287}. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado al lado. {npc:2449} camina por la calle al norte.",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, en {zone:1458}",

	-- Step 18: Town hall
	["Town hall"] = "Ayuntamiento",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "El ayuntamiento está en el lado oeste de {area:287}. {npc:2335} (30) y {npc:2448} están dentro con el Registro de Trabalomas; la Proclamación de Trabalomas está clavada al lado. Los Consejeros recorren el pueblo.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 20: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "La {area:288} está al sur del pueblo de {area:287}. Los Mineros trabajan en los túneles; {npc:2305} (30) y {npc:2450} (29) están al fondo.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 24: To the Undercity
	-- {zone:1458} Undercity
	["To the {zone:1458}"] = "",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {area:85} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {area:85}; the {zone:1458} lies below the {area:153}. The bat handler is in the {object:36078}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 25: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "",

	-- Step 26: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, en la botica real",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Guárdala: la costa de {area:287}, más adelante en la ruta",

	-- Step 27: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 29: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 30: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 31: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Toma el zepelín en las torres fuera de {zone:1458} hacia {zone:1454} y entrena antes de seguir volando.",

	-- Step 35: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Desde {zone:1454} (zepelín en las torres fuera de {zone:1458}) vuela a {area:378}.",

	-- Step 37: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La choza de {npc:5899} está en la cresta sobre el abrevadero de los jabaespines, al sur de {area:378}, camino a {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: el odre rojo de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: el odre azul se llena en {zone:1440}, en la siguiente guía",

	-- Step 38: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Sigue el camino al sur hasta la excavación enana de {area:359}. {npc:3421} se esconde en el borde sur de la excavación; {object:3646} está en el fondo.",
	-- {object:3646} General Twinbraid's Strongbox
	["{object:3646}; below ground"] = "",

	-- Step 39: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 40: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "",
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {area:17} The Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {area:17}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "",

	-- Step 41: Hearth to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Hearth to {area:378}"] = "",

	-- Step 42: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 43: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, junto a los muelles de {area:392}",

	-- Step 44: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Usa tu piedra de hogar a {area:378} y vuela a {area:392}. {quest:874} acampa en la orilla al norte de {area:392}.",

	-- Step 45: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un gran trillanodonte, nada en las aguas poco profundas frente a {area:391}, al este de {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull y {npc:2238} están encadenados en los edificios del patio de {area:275}; abre ambos candados.",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Desde {area:272} ve al sureste por las colinas camino a {area:275}. Pícaros y Veladores ocupan los campamentos del camino.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Desde {zone:1454} (zepelín en las torres fuera de {zone:1458}) vuela a {area:1638} y entrena en {area:1639}; luego vuela a {area:378}.",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "¿Aún sin Gallywix? La guía de clase Venenos (Horda) vuelve a hacer la cadena desde Shenthul, con un grupo para Gallywix.",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "¿Aún sin Gallywix? La guía de clase {spell:2842} (Horda) vuelve a hacer la cadena desde Shenthul, con un grupo para Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Solo si Gallywix cayó en {zone:1413} (Misión: Posible, pero no probable): {npc:2391} está en {area:272}. Espera a su lado mientras prepara la cura y luego toma tu recompensa: Venenos.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Solo si Gallywix cayó en {zone:1413} (Misión: Posible, pero no probable): {npc:2391} está en {area:272}. Espera a su lado mientras prepara la cura y luego toma tu recompensa: {spell:2842}.",
	-- ["Peasants and skulls"] = "Campesinos y cráneos",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "Al suroeste de Bael Modan, {npc:12576} espera en lo alto de {area:485}.",
	-- ["Syndicate camps"] = "Campamentos de la Hermandad",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Los Campesinos trabajan los campos al sur de las granjas. Todo humano de {area:287} suelta cráneos; los Campesinos, con más frecuencia.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "La herrería está en el centro del pueblo de {area:287}. {npc:2404} y sus aprendices trabajan en la forja; el {item:3564} está apilado al lado. {npc:2449} camina por la calle al norte.",
	-- ["The {object:1763} poster by the inn"] = "El cartel de {object:1763} junto a la posada",
	-- ["The {quest:567} poster: its targets come up along the way"] = "El cartel de {quest:567}: sus objetivos aparecen en el camino",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Llegas vinculado a la posada de {area:272}. Todos están alrededor de la plaza del pueblo.",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}, junto a Lydon",
}
