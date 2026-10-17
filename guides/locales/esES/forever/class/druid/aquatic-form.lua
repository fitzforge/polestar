-- Spanish (Spain) (esES): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Tu forma de viaje acuática: nada rápido y respira bajo el agua, y además un cinturón y un ídolo.",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} está en {area:1658}.",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. Los adornos de altar ({item:15877}) están en los contenedores del fondo de {area:656}, bajo {area:2361}: lleva uno al {area:2362}, en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de un {object:177785} del lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "En el {area:2362}",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Vuela de {area:2361} a {area:442}. {object:177792} está bajo el agua frente a la costa norte, al oeste de {area:443}.",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Toma el barco de {area:442} a {zone:1453} y vuela a {area:108}. Cabalga al noroeste hasta la costa: la {object:177790} está en el fondo del mar frente a la orilla.",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lanza {spell:18960}. Une las dos mitades en {item:15885} cerca del {area:2362}, en la orilla noroeste del lago, y luego ve a ver a {npc:11802} en {area:2361}. Después, vuela a {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: une las mitades en el altar",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Toma el portal para subir hasta {npc:4217} en {area:1658}.",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} está en {area:1639}.",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. Los adornos de altar ({item:15877}) están en el fondo de {area:656} y desaparecen en pocos minutos: lleva uno a nado directamente al {area:2362}, en la orilla noroeste, úsalo allí y habla con {npc:11799}.",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Toma el vuelo de {npc:11798} a {zone:1456}, vuela a {zone:1454} y toma el zepelín a {zone:1420}; {zone:1421} está al sur de {zone:1458}. La {object:177790} está en la costa al oeste de {area:240}, al norte de {area:228}.",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792} está en el borde norte de {area:382}, junto a la torre de Ventura y Cía., al norte de {area:380}.",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lanza {spell:18960}. Une las dos mitades en {item:15885} cerca del {area:2362}, en la orilla noroeste del lago, y luego ve a ver a {npc:11802} en {area:2361}. {npc:11798} lleva a los druidas a {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lanza Teletransporte: {zone:1450}. Une las dos mitades en {item:15885} cerca del {area:2362}, en la orilla noroeste del lago, y luego ve a ver a {npc:11802} en {area:2361}. Después, vuela a {area:702}.",
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lanza Teletransporte: {zone:1450}. Une las dos mitades en {item:15885} cerca del {area:2362}, en la orilla noroeste del lago, y luego ve a ver a {npc:11802} en {area:2361}. {npc:11798} lleva a los druidas a {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza Teletransporte: {zone:1450}. {npc:11802} está en {area:2361}. Los Adornos de altar están en los contenedores del fondo de {area:656}, bajo {area:2361}: lleva uno al {area:2362}, en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza Teletransporte: {zone:1450}. {npc:11802} está en {area:2361}. Los Adornos de altar están en el fondo de {area:656} y desaparecen en pocos minutos: lleva uno a nado directamente al {area:2362}, en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
}
