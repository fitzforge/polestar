-- Spanish (Latin America) (esMX): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Reputación: Cuenca de Arathi",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "Cada 200 recursos que junta tu equipo la suben; Exaltado da un Punto de legado, hombreras épicas y el tabardo.",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "Maestro de la Cuenca de Arathi: un Punto de legado en Exaltado",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461} es una batalla de 15 contra 15 por cinco bases, desde el nivel 20: mantén bases para juntar recursos, y el primer equipo en llegar a 2000 gana. Entra a la cola con cualquier maestro de batalla de las capitales o desde la pantalla de campos de batalla. En Classic cada 200 recursos que junta tu equipo pagan 10 de reputación a todos, así que una victoria paga 100 y una derrota ajustada casi lo mismo; una partida también paga 3 Marcas de Honor de la Cuenca de Arathi si ganas, 1 si pierdes. Las tres misiones de aquí pagan 500 de reputación entre todas (200, 200 y 100), una vez. La ventaja Diplomático del Legado de Forever suma hasta un 10% a cada número de esta guía.",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983}: asalta cuatro bases, 200",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984}: una marca, 200",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351}: tres marcas, 100",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Asaltar una base significa hacer clic en su estandarte hasta que cambie: no hace falta mantenerla. Cuatro marcas en total: una para {npc:14984}, tres para el general de brigada. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1461}: entrégalas o gástalas antes de llegar a eso.",
	["Assault the Mine banner"] = "Asalta el estandarte de la Mina",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "Asalta el estandarte de {area:3422}",
	["Assault the Blacksmith banner"] = "Asalta el estandarte de la Herrería",
	["Assault the Farm banner"] = "Asalta el estandarte de la Granja",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "una {item:20559}",
	["three more marks"] = "tres marcas más",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "De vuelta en {area:320}",
	["hand in the three marks first"] = "entrega primero las tres marcas",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "Liga de Arathor hasta Amistoso",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "De Neutral a Amistoso son 3000 de reputación. En Classic una victoria pagaba 100 y sus 3 marcas dan 50 más con el general de brigada ({quest:8374}, una y otra vez): unos 150 por victoria, unas 20 victorias. Forever no ha publicado sus valores de campo de batalla, así que toma el número de partidas como una guía aproximada. Por debajo del nivel 50, las misiones de {area:320} vienen en una versión para tu rango (desde el nivel 20): 200 por asaltar las bases, 200 por una marca, y luego 100 y 50 por cada 3 marcas con el general de brigada.",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351}: {quest:8374} otra vez, 50 de reputación por 3 marcas",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "A nivel 60 y en Amistoso, {npc:14983} le pide a tu equipo mantener cuatro bases al mismo tiempo: 200 de reputación, una vez. Abre {quest:8115} para Exaltado.",
	["four bases held at once"] = "cuatro bases mantenidas a la vez",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "Liga de Arathor hasta Honorable",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amistoso a Honorable son 6000 de reputación, unas 40 victorias al ritmo de Classic. Amistoso abre las primeras recompensas con {npc:15127}, junto a {npc:14983}: el abalorio {item:20071} para niveles 28, 38, 48 y 58 (de 72s a 4g12s), y comida y vendas que funcionan en {zone:1461} (de 10s a 20s). También da un paquete de provisiones de Arathor en Amistoso (elige el de tu nivel): 10 de reputación y una bolsa de comida y vendas de campo de batalla.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127}: recompensas de Amistoso",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}: 50 de reputación por 3 marcas",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "Liga de Arathor hasta Reverenciado",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "De Honorable a Reverenciado son 12000 de reputación, unas 80 victorias. Honorable abre los cinturones de montañés en placas, laminado, cota, malla, cuero, piel de lagarto y tela para niveles 28 a 58 (de 72s a 8g84s).",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127}: recompensas de Honorable",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "Liga de Arathor hasta Exaltado",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "De Reverenciado a Exaltado son 21000 de reputación, unas 140 victorias: la mitad de toda la subida. Reverenciado abre las botas y grebas de montañés para niveles 28 a 58 (de 1g7s a 13g65s), las que tienen la bonificación de velocidad de carrera.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127}: recompensas de Reverenciado",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "Exaltado da el Punto de legado \"Maestro de la Cuenca de Arathi\" y abre los épicos: las hombreras de montañés de nivel 60 en todos los tipos de armadura (de 12g33s a 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) y Garrasabia (44g24s), ambos desde el nivel 55.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127}: recompensas de Exaltado",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "En Exaltado, {npc:14983} le pide a tu equipo mantener las cinco bases al mismo tiempo. Paga 200 de reputación y el {item:20132}, la única forma de conseguirlo.",
	["all five bases held at once"] = "las cinco bases mantenidas a la vez",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021}: asalta cuatro bases, 200",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022}: una marca, 200",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350}: tres marcas, 100",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Asaltar una base significa hacer clic en su estandarte hasta que cambie: no hace falta mantenerla. Cuatro marcas en total: una para {npc:15022}, tres para el Belisario. El equipo JcJ de Forever también cuesta Marcas de Honor además de honor: decide qué quieres antes de entregarlas. Puedes llevar como máximo 30 marcas de {zone:1461}: entrégalas o gástalas antes de llegar a eso.",
	["Assault the Stables banner"] = "Asalta el estandarte de los Establos",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De vuelta a {area:321}",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} hasta Amistoso",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "De Neutral a Amistoso son 3000 de reputación. En Classic una victoria pagaba 100 y sus 3 marcas dan 50 más con el Belisario ({quest:8370}, una y otra vez): unos 150 por victoria, unas 20 victorias. Forever no ha publicado sus valores de campo de batalla, así que toma el número de partidas como una guía aproximada. Por debajo del nivel 50, las misiones de {area:321} vienen en una versión para tu rango (desde el nivel 20): 200 por asaltar las bases, 200 por una marca, y luego 100 y 50 por cada 3 marcas con el Belisario.",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350}: {quest:8370} otra vez, 50 de reputación por 3 marcas",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "A nivel 60 y en Amistoso, {npc:15021} le pide a tu equipo mantener cuatro bases al mismo tiempo: 200 de reputación, una vez. Abre {quest:8122} para Exaltado.",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} hasta Honorable",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "De Amistoso a Honorable son 6000 de reputación, unas 40 victorias al ritmo de Classic. Amistoso abre las primeras recompensas con {npc:15126}, junto a {npc:15021}: el abalorio {item:20072} para niveles 28, 38, 48 y 58 (de 72s a 4g12s), y comida y vendas que funcionan en {zone:1461} (de 10s a 20s). También da un paquete de provisiones de los Rapiñadores en Amistoso (elige el de tu nivel): 10 de reputación y una bolsa de comida y vendas de campo de batalla.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126}: recompensas de Amistoso",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}: 50 de reputación por 3 marcas",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} hasta Reverenciado",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "De Honorable a Reverenciado son 12000 de reputación, unas 80 victorias. Honorable abre los cinturones de Rapiñador en placas, laminado, cota, malla, cuero, piel de lagarto y tela para niveles 28 a 58 (de 75s a 8g78s).",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126}: recompensas de Honorable",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} hasta Exaltado",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "De Reverenciado a Exaltado son 21000 de reputación, unas 140 victorias: la mitad de toda la subida. Reverenciado abre las botas y grebas de Rapiñador para niveles 28 a 58 (de 1g12s a 13g41s), las que tienen la bonificación de velocidad de carrera.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126}: recompensas de Reverenciado",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "Exaltado da el Punto de legado \"Maestro de la Cuenca de Arathi\" y abre los épicos: las hombreras de Rapiñador de nivel 60 en todos los tipos de armadura (de 12g75s a 20g), {item:20068} (13g18s), {item:20069} (50g46s) y Colmillomental (42g83s), ambos desde el nivel 55.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126}: recompensas de Exaltado",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "En Exaltado, {npc:15021} le pide a tu equipo mantener las cinco bases al mismo tiempo. Paga 200 de reputación y el {item:20131}, la única forma de conseguirlo.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "Ser Exaltado con la Liga de Arathor otorga un Punto de legado.",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "Ser Exaltado con {faction:510} otorga un Punto de legado.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1461}. En los fines de semana de Llamada a las armas: {zone:1461}, {npc:15350} en las capitales acepta tres Marcas de Honor de la Cuenca de Arathi a cambio de reputación extra.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1461}. En los fines de semana de Llamada a las armas: {zone:1461}, {npc:15351} en las capitales acepta tres Marcas de Honor de la Cuenca de Arathi a cambio de reputación extra.",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Sigue jugando en {zone:1461}; las victorias con muchas bases controladas son las que más dan.",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} lucha por {zone:1461} desde {area:320}. Su reputación viene del campo de batalla: los recursos que reúne tu equipo se la dan a todos, así que mantener más bases por más tiempo da más. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} luchan por {zone:1461} desde {area:321}. Su reputación viene del campo de batalla: los recursos que reúne tu equipo se la dan a todos, así que mantener más bases por más tiempo da más. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "La batalla por {zone:1461} (asalta todas las bases) y Controla cuatro bases / Controla cinco bases de {npc:14983} son misiones de una sola vez; {npc:14984}, a su lado, acepta Cajones de recursos de Arathi.",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "La batalla por {zone:1461} (asalta todas las bases) y Toma el control de cuatro bases / Toma el control de cinco bases de {npc:15021} son misiones de una sola vez; {npc:15022}, a su lado, acepta Cajones de recursos de Arathi.",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} entrega un botiquín de Rapiñador según tu nivel",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} entrega un botiquín de Arathor según tu nivel",
}
