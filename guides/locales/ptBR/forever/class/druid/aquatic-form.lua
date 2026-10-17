-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Sua forma de viagem aquática: nade rápido e respire debaixo d'água, com um cinto e um ídolo de quebra.",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} fica no {area:1658}.",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Adornos de Altar ficam nos recipientes no fundo de {area:656}, abaixo de {area:2361}: leve um até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de um {object:177785} no lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "No {area:2362}",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Voe de {area:2361} até {area:442}. O {object:177792} está debaixo d'água perto da costa norte, a oeste das {area:443}.",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Pegue o navio de {area:442} até {zone:1453} e voe até {area:108}. Cavalgue para noroeste até a costa: o {object:177790} está no fundo do mar perto da praia.",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lance {spell:18960}. Junte as duas metades no {item:15885} perto de {area:2362}, na margem noroeste do lago, e depois fale com {npc:11802} em {area:2361}. Depois voe até {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: junte as metades no santuário",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Pegue o portal até {npc:4217} no {area:1658}.",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} fica no {area:1639}.",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Os Adornos de Altar ficam no fundo de {area:656} e somem em poucos minutos: nade com um direto até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Pegue o voo de {npc:11798} até {zone:1456}, voe até {zone:1454} e pegue o zepelim até {zone:1420}; {zone:1421} fica ao sul de {zone:1458}. O {object:177790} está na costa a oeste do {area:240}, ao norte do {area:228}.",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "O {object:177792} está na borda norte do {area:382}, perto da torre da Empreendimentos S.A., ao norte da {area:380}.",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lance {spell:18960}. Junte as duas metades no {item:15885} perto de {area:2362}, na margem noroeste do lago, e depois fale com {npc:11802} em {area:2361}. {npc:11798} leva druidas voando até {area:1638}.",
}
