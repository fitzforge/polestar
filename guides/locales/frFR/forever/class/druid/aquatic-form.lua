-- French (frFR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Votre forme de voyage aquatique : nagez vite et respirez sous l'eau, avec en plus une ceinture et une idole.",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} se tient dans l'{area:1658}.",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) se trouvent dans les conteneurs au fond du {area:656}, en contrebas de {area:2361} : apportez-en un au {area:2362} sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Au {area:2362}",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Volez de {area:2361} à {area:442}. L'{object:177792} se trouve sous l'eau au large de la côte nord, à l'ouest des {area:443}.",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Prenez le bateau d'{area:442} à {zone:1453} et volez jusqu'à la {area:108}. Allez vers le nord-ouest jusqu'à la côte : l'{object:177790} repose sur le fond marin au large du rivage.",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lancez {spell:18960}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. Volez ensuite jusqu'à {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885} : assemblez les moitiés au sanctuaire",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Prenez le portail qui monte jusqu'à {npc:4217}, dans l'{area:1658}.",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} se tient sur la {area:1639}.",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) reposent au fond du {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'au {area:2362} sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Prenez le vol de {npc:11798} jusqu'à {zone:1456}, volez jusqu'à {zone:1454} et prenez le zeppelin pour {zone:1420} ; {zone:1421} se trouve au sud d'{zone:1458}. L'{object:177790} se trouve sur la côte à l'ouest du champ ({area:240}), au nord de la crypte ({area:228}).",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "L'{object:177792} se trouve à la lisière nord de {area:382}, près de la tour de la KapitalRisk, au nord de {area:380}.",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lancez {spell:18960}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. {npc:11798} transporte les druides jusqu'à {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lancez Téléportation : {zone:1450}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. Volez ensuite jusqu'à {area:702}.",
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lancez Téléportation : {zone:1450}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. {npc:11798} emmène les druides en vol jusqu'à {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Les Colifichets du sanctuaire reposent dans les conteneurs au fond du {area:656}, en contrebas d'{area:2361} : apportez-en une au {area:2362}, sur la rive nord-ouest, utilisez-la là-bas et parlez à {npc:11799}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Les Colifichets du sanctuaire reposent au fond du {area:656} et disparaissent en quelques minutes : nagez directement avec l'une d'elles jusqu'au {area:2362}, sur la rive nord-ouest, utilisez-la là-bas et parlez à {npc:11799}.",
}
