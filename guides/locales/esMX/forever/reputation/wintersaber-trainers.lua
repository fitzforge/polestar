-- Spanish (Latin America) (esMX): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "Reputación con los Entrenadores de sables de invierno",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "El {spell:17229}: 840 entregas de misiones en {zone:1452}, con reputación Fauces de Madera de paso.",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "Reputación con {area:1769} de paso: 50 y unas 4 {item:21383} por {quest:5201}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618} está en lo alto de {area:2241}, en el extremo norte de {zone:1452}; el camino sube serpenteando desde el lado este. Solo la Alianza puede ganarse el favor de los {faction:589}, desde Neutral, a nivel 58. Sus tres misiones pagan 50 y se repiten cuantas veces quieras: 840 entregas de Neutral a Exaltado. La primera, {quest:4970}, es la única abierta al principio.",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "Carne de Shardtooth y de Chillwind",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "La carne solo cae mientras tienes la misión en tu registro, y un grupo no comparte el botín: fármala solo. Los que más la sueltan viven justo debajo de la roca: los osos {npc:7445} (más o menos la mitad de las veces) y los asoladores Chillwind (la mitad de las veces) recorren las llanuras nevadas al este y sureste. Alrededor de {area:2255} las quimeras Chillwind la sueltan igual de seguido y los osos Shardtooth un poco menos; los {npc:7446} junto al desfiladero de los gigantes, en el sur, son los que más la sueltan (seis de cada diez).",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622}: los osos",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623}: las quimeras",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "De vuelta con {npc:10618}",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "De Neutral a Amistoso: {quest:4970}, luego {quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "Repite {quest:4970}: 30 entregas te llevan a Neutral 1.500, y entonces se abre {quest:5201}: 5 chamanes Nevada y 5 ursas Nevada en {area:2244}, justo al este de {area:2255}. La aldea tiene pocos chamanes, pero todos los fúrbolgs de ahí comparten sus puntos de aparición: mátalos a todos, no solo a los que necesitas, y aparecen más chamanes y ursas; más ursas recorren la cresta justo al suroeste de la aldea. Toma las dos misiones en cada viaje: mata a los fúrbolgs y recoge carne de regreso. De Neutral a Amistoso son 60 entregas.",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "De Amistoso a Honorable",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "De Amistoso a Honorable son 6.000: 120 entregas. {quest:5201} es la más rápida; haz {quest:4970} cuando la aldea esté llena o pases de todos modos junto a los osos y las quimeras. Cada fúrbolg Nevada que mates cuenta también para {area:1769}: 50 de reputación Fauces de Madera por {quest:5201} hasta el final de Honorable con ellos, y unas cuatro {item:21383}. Toma Actividad Nevada de Salfa (la guía Fauces de Madera) la primera vez que estés en la aldea, y guarda las cuentas hasta que tus muertes Fauces de Madera dejen de contar: entonces cada 5 pagan 50. Llegarás a Exaltado con los Fauces de Madera mucho antes que con los {faction:589}.",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "De Honorable a Exaltado: también {quest:5981}",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "En Honorable Rivern Frostwind suma {quest:5981}: 4 gigantes Machacahielo y 4 preservadores Machacahielo, gigantes élite en {area:2249}, en el sureste de {zone:1452}; el camino para bajar al desfiladero empieza en su extremo noroeste. Hazla en un viaje al sur con uno o dos amigos, o cuando {area:2244} esté llena; los {npc:7446} junto al desfiladero son los que más sueltan {item:12622}. De Honorable a Exaltado son 33.000: 660 entregas.",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}, élite",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}, élite",
}
