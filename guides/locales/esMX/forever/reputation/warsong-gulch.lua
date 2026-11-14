-- Spanish (Latin America) (esMX): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Reputación: Garganta Grito de Guerra",
	["Flag captures and Marks of Honor raise it; Exalted gives a Legacy Point and epic bracers and legs."] = "Las capturas de bandera y las Marcas de Honor la suben; Exaltado da un Punto de legado y brazales y piernas épicos.",
	["Master of Warsong Gulch: a Legacy Point at Exalted"] = "Maestro de la Garganta Grito de Guerra: un Punto de legado en Exaltado",

	-- Step 1: Sentinel Farsong
	-- {zone:1460} Warsong Gulch · {npc:14733} Sentinel Farsong
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14733} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} es una batalla de captura la bandera de 10 contra 10, desde el nivel 10. Entra a la cola con cualquier maestro de batalla de las capitales o desde la pantalla de campos de batalla. En Classic cada bandera que captura tu equipo paga 35 de reputación a todos (45 el fin de semana festivo de {zone:1460}), y una partida paga 3 Marcas de Honor de la Garganta Grito de Guerra si ganas, 1 si pierdes. {npc:14733} paga 200 de reputación por una marca, una vez por personaje: la mejor marca que vas a entregar. La ventaja Diplomático del Legado de Forever suma hasta un 10% a cada número de esta guía.",
	-- {item:20558} Warsong Gulch Mark of Honor
	["one {item:20558}: play a game"] = "una {item:20558}: juega una partida",

	-- Step 2: Alliance Brigadier General
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch · {area:3319} Silverwing Grove · {npc:14733} Sentinel Farsong · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1460} Warsong Gulch
	["The {npc:15351} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8372}). One stands right here at {area:3319} beside {npc:14733}; others in {zone:1453}, {zone:1455} and {zone:1457}, at {area:320} in the {zone:1417} and at both gates of {zone:1459}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "El {npc:15351} paga 100 de reputación por 3 Marcas de Honor de la Garganta Grito de Guerra la primera vez, y luego 50 por cada 3 más ({quest:8372}). Hay uno aquí mismo en {area:3319}, junto a {npc:14733}; otros en {zone:1453}, {zone:1455} y {zone:1457}, en {area:320} en {zone:1417} y en las dos puertas de {zone:1459}. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1460}: entrégalas o gástalas antes de llegar a eso.",
	["three Warsong Gulch Marks of Honor"] = "tres Marcas de Honor de la Garganta Grito de Guerra",

	-- Step 3: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} hasta Amistoso",
	-- {npc:14733} Sentinel Farsong · {quest:8372} Fight for Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Brigadier General: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14733}'s one-mark quest and the Brigadier General's {quest:8372} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "De Neutral a Amistoso son 3000 de reputación. En Classic una victoria con 3 capturas pagaba 105, y sus 3 marcas dan 50 más con el general de brigada: unos 155 por victoria, así que unas 20 victorias. Las derrotas igual pagan 35 por cada bandera que capturó tu equipo. Forever no ha publicado sus valores de campo de batalla, así que toma el número de partidas como una guía aproximada. Por debajo del nivel 50, la misión de una marca de {npc:14733} y {quest:8372} del general de brigada vienen en una versión para tu rango (desde 20 y desde 10): 200 una vez, y luego 100 y 50 por cada 3 marcas.",
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch
	["{npc:15351}: {quest:8372} again, 50 reputation for 3 marks"] = "{npc:15351}: {quest:8372} otra vez, 50 de reputación por 3 marcas",

	-- Step 4: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} hasta Honorable",
	-- {npc:14753} Illiyana Moonblaze · {npc:14733} Sentinel Farsong · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14753} beside {npc:14733}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). She also gives one Sentinel care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amistoso a Honorable son 6000 de reputación, unas 39 victorias al ritmo de Classic. Amistoso abre las primeras recompensas con {npc:14753}, junto a {npc:14733}: los abalorios {item:21567} y {item:21565} (2 de oro a nivel 20, 4 de oro a nivel 40) y comida, vendas y tragos que funcionan en el campo de batalla (de 5s a 20s). También da un paquete de provisiones de centinela en Amistoso (elige el de tu nivel): 10 de reputación y una bolsa de comida y vendas de campo de batalla.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Friendly rewards"] = "{npc:14753}: recompensas de Amistoso",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}: 50 de reputación por 3 marcas",

	-- Step 5: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} hasta Reverenciado",
	-- {item:19530} Caretaker's Cape · {item:19538} Sentinel's Medallion · {item:19522} Lorekeeper's Ring · {item:19514} Protector's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19530} (cloak), {item:19538} (neck), {item:19522} and {item:19514}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 8g55s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "De Honorable a Reverenciado son 12000 de reputación, unas 78 victorias. Honorable abre {item:19530} (capa), {item:19538} (cuello), {item:19522} y {item:19514}, cada uno a la venta para niveles 18, 28, 38, 48 y 58 (capa de 36s50c a 8g55s, el resto de 2 de oro a 7g50s), y los tragos de sanación y de maná sublimes (10s).",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Honored rewards"] = "{npc:14753}: recompensas de Honorable",

	-- Step 6: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} hasta Exaltado",
	-- {item:19546} Sentinel's Blade · {item:19554} Protector's Sword · {item:19562} Outrunner's Bow · {item:19570} Lorekeeper's Staff · {item:211498} Trainee's Sentinel Nightsaber
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19546} (dagger), {item:19554}, {item:19562} and {item:19570} (91s to 35g61s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the {item:211498} mount (level 25, 10g) with no standing listed."] = "",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Revered rewards"] = "{npc:14753}: recompensas de Reverenciado",

	-- Step 7: Illiyana Moonblaze
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19506} Silverwing Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Sentinel's legs in plate, lamellar, chain, leather, lizardhide and silk (16g63s to 24g22s). The {item:19506} is 5g."] = "Exaltado da el Punto de legado \"Maestro de la Garganta Grito de Guerra\" y abre los épicos: {item:19578} (placas), {item:19582} (malla), {item:19587} (cuero) y {item:19595} (tela) para niveles 40, 50 y 60 (de 2g47s a 12g11s), y las piernas de centinela de nivel 60 en placas, laminado, cota, cuero, piel de lagarto y seda (de 16g63s a 24g22s). El {item:19506} cuesta 5 de oro.",
	-- {item:19506} Silverwing Battle Tabard
	["{item:19506}, 5g"] = "{item:19506}, 5 de oro",

	-- Step 8: Captain Shatterskull
	-- {zone:1460} Warsong Gulch · {area:1599} Mor'shan Base Camp · {npc:14781} Captain Shatterskull
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen; the Horde gate is here at {area:1599}. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14781} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} es una batalla de captura la bandera de 10 contra 10, desde el nivel 10. Entra a la cola con cualquier maestro de batalla de las capitales o desde la pantalla de campos de batalla; la puerta de la Horda está aquí, en {area:1599}. En Classic cada bandera que captura tu equipo paga 35 de reputación a todos (45 el fin de semana festivo de {zone:1460}), y una partida paga 3 Marcas de Honor de la Garganta Grito de Guerra si ganas, 1 si pierdes. {npc:14781} paga 200 de reputación por una marca, una vez por personaje: la mejor marca que vas a entregar. La ventaja Diplomático del Legado de Forever suma hasta un 10% a cada número de esta guía.",

	-- Step 9: Horde Warbringer
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {area:321} Hammerfall · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {zone:1460} Warsong Gulch
	["The {npc:15350} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8368}). One stands right here at Mor'shan; others in {zone:1454}, {zone:1456} (and on the plain below it) and the {zone:1458}, at {area:321} in the {zone:1417} and at the {zone:1459} gate in the {zone:1416}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "El {npc:15350} paga 100 de reputación por 3 Marcas de Honor de la Garganta Grito de Guerra la primera vez, y luego 50 por cada 3 más ({quest:8368}). Hay uno aquí mismo en Mor'shan; otros en {zone:1454}, {zone:1456} (y en la llanura de abajo) y {zone:1458}, en {area:321} en {zone:1417} y en la puerta de {zone:1459} en {zone:1416}. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1460}: entrégalas o gástalas antes de llegar a eso.",

	-- Step 10: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} hasta Amistoso",
	-- {npc:14781} Captain Shatterskull · {quest:8368} Battle of Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Warbringer: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14781}'s one-mark quest and the Warbringer's {quest:8368} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "De Neutral a Amistoso son 3000 de reputación. En Classic una victoria con 3 capturas pagaba 105, y sus 3 marcas dan 50 más con el Belisario: unos 155 por victoria, así que unas 20 victorias. Las derrotas igual pagan 35 por cada bandera que capturó tu equipo. Forever no ha publicado sus valores de campo de batalla, así que toma el número de partidas como una guía aproximada. Por debajo del nivel 50, la misión de una marca de {npc:14781} y {quest:8368} del Belisario vienen en una versión para tu rango (desde 20 y desde 10): 200 una vez, y luego 100 y 50 por cada 3 marcas.",
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch
	["{npc:15350}: {quest:8368} again, 50 reputation for 3 marks"] = "{npc:15350}: {quest:8368} otra vez, 50 de reputación por 3 marcas",

	-- Step 11: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} hasta Honorable",
	-- {npc:14754} Kelm Hargunth · {npc:14781} Captain Shatterskull · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14754} beside {npc:14781}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). He also gives one Outrider care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amistoso a Honorable son 6000 de reputación, unas 39 victorias al ritmo de Classic. Amistoso abre las primeras recompensas con {npc:14754}, junto a {npc:14781}: los abalorios {item:21567} y {item:21565} (2 de oro a nivel 20, 4 de oro a nivel 40) y comida, vendas y tragos que funcionan en el campo de batalla (de 5s a 20s). También da un paquete de provisiones de batidor en Amistoso (elige el de tu nivel): 10 de reputación y una bolsa de comida y vendas de campo de batalla.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Friendly rewards"] = "{npc:14754}: recompensas de Amistoso",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}: 50 de reputación por 3 marcas",

	-- Step 12: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} hasta Reverenciado",
	-- {item:19526} Battle Healer's Cloak · {item:19534} Scout's Medallion · {item:19518} Advisor's Ring · {item:19510} Legionnaire's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19526}, {item:19534} (neck), {item:19518} and {item:19510}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 9g6s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "De Honorable a Reverenciado son 12000 de reputación, unas 78 victorias. Honorable abre {item:19526}, {item:19534} (cuello), {item:19518} y {item:19510}, cada uno a la venta para niveles 18, 28, 38, 48 y 58 (capa de 36s50c a 9g6s, el resto de 2 de oro a 7g50s), y los tragos de sanación y de maná sublimes (10s).",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Honored rewards"] = "{npc:14754}: recompensas de Honorable",

	-- Step 13: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} hasta Exaltado",
	-- {item:19542} Scout's Blade · {item:19550} Legionnaire's Sword · {item:19558} Outrider's Bow · {item:19566} Advisor's Gnarled Staff · {item:211499} Trainee's Outrider Wolf
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19542} (dagger), {item:19550}, {item:19558} and {item:19566} (91s to 35g9s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the {item:211499} mount (level 25, 10g) with no standing listed."] = "",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Revered rewards"] = "{npc:14754}: recompensas de Reverenciado",

	-- Step 14: Kelm Hargunth
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19505} Warsong Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Outrider's legs in plate, chain, mail, leather, lizardhide and silk (16g57s to 25g33s). The {item:19505} is 5g."] = "Exaltado da el Punto de legado \"Maestro de la Garganta Grito de Guerra\" y abre los épicos: {item:19578} (placas), {item:19582} (malla), {item:19587} (cuero) y {item:19595} (tela) para niveles 40, 50 y 60 (de 2g47s a 12g11s), y las piernas de batidor de nivel 60 en placas, cota, malla, cuero, piel de lagarto y seda (de 16g57s a 25g33s). El {item:19505} cuesta 5 de oro.",
	-- {item:19505} Warsong Battle Tabard
	["{item:19505}, 5g"] = "{item:19505}, 5 de oro",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:889} earns a Legacy Point."] = "Ser Exaltado con {faction:889} otorga un Punto de legado.",
	-- ["Exalted with the {faction:890} earns a Legacy Point."] = "Ser Exaltado con {faction:890} otorga un Punto de legado.",
	-- ["Keep capturing flags in {zone:1460}."] = "Sigue capturando banderas en {zone:1460}.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1460} y capturando banderas. En los fines de semana de Llamada a las armas: {zone:1460}, {npc:15350} en las capitales acepta tres Marcas de Honor de la Garganta Grito de Guerra a cambio de reputación extra.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1460} y capturando banderas. En los fines de semana de Llamada a las armas: {zone:1460}, {npc:15351} en las capitales acepta tres Marcas de Honor de la Garganta Grito de Guerra a cambio de reputación extra.",
	-- ["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19542} (dagger), {item:19550}, {item:19558} and {item:19566} (91s to 35g9s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Outrider Wolf mount (level 25, 10g) with no standing listed."] = "De Reverenciado a Exaltado son 21000 de reputación, unas 136 victorias: la mitad de toda la subida. Reverenciado abre las armas para niveles 18 a 58: {item:19542} (daga), {item:19550}, {item:19558} y {item:19566} (de 91s a 35g9s). El intendente de Forever también vende versiones de nivel 25 de las cuatro armas, yelmos resistentes para nivel 20 (2g50s) y la montura lobo de batidor de aprendiz (nivel 25, 10 de oro) sin reputación indicada.",
	-- ["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19546} (dagger), {item:19554}, {item:19562} and {item:19570} (91s to 35g61s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Sentinel Nightsaber mount (level 25, 10g) with no standing listed."] = "De Reverenciado a Exaltado son 21000 de reputación, unas 136 victorias: la mitad de toda la subida. Reverenciado abre las armas para niveles 18 a 58: {item:19546} (daga), {item:19554}, {item:19562} y {item:19570} (de 91s a 35g61s). El intendente de Forever también vende versiones de nivel 25 de las cuatro armas, yelmos resistentes para nivel 20 (2g50s) y la montura sable de la noche de centinela de aprendiz (nivel 25, 10 de oro) sin reputación indicada.",
	-- ["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} son los orcos que talan {zone:1440}. Su reputación viene del campo de batalla: cada bandera enemiga que captura tu equipo se la otorga a todo el equipo. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} son los elfos de la noche que defienden {zone:1460}. Su reputación viene del campo de batalla: cada bandera enemiga que captura tu equipo se la otorga a todo el equipo. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} acepta Marcas de Honor de la Garganta Grito de Guerra para ¡Expulsa al invasor!, una vez por rango de nivel (según los datos); compruébalo en el juego.",
	-- ["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} entrega un paquete de provisiones de las Centinelas según el nivel",
	-- ["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} entrega un paquete de provisiones de los Escoltas según el nivel",
	-- ["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} acepta Marcas de Honor de la Garganta Grito de Guerra para Acaba con los usurpadores Ala de Plata, una vez por rango de nivel (según los datos); compruébalo en el juego.",
}
