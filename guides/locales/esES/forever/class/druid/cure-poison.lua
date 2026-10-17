-- Spanish (Spain) (esES): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "En Forever ya no se aprende {spell:8946} con el instructor: te lo enseña esta cadena, que además da una bolsa de medicinas.",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} está en el {area:1658}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. Luego vuela a {area:442}.",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Cabalga al noreste desde {area:442} hasta {area:445} y llena el {item:15844} en la entrada de la cueva junto a la cascada.",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "De vuelta en {area:442}.",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} y {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Las flores de hongo lunar ({object:177750}) crecen en las cuevas de los lechúcicos de las colinas justo al este de {area:442}; los lechúcicos de allí son irritables. La {item:2449} requiere {skill:182}: los herboristas la recogen por todo {zone:1439}; los demás la compran a {npc:1313} (Suministros de alquimia) en {zone:1453} o en la casa de subastas.",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Usa el {item:15826} en los {npc:12298}. Deambulan por {zone:1439}, desde el {area:456} al norte hasta la frontera con {zone:1440} al sur.",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298}: usa el ungüento en ellos",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lanza {spell:18960} y habla con {npc:11802}; luego vuela a {area:702} y toma el portal para subir a {zone:1457}.",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} está en {area:1639}.",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. {npc:11798} lleva a los druidas a {area:1638}; desde allí, vuela a {area:380}.",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words)
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Desde {area:380}, cabalga al norte hasta {area:384} y llena el {item:15842} en la {object:19464}.",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} está en {area:380}. ¿No tienes {skill:182}? {npc:3490}, a pocos pasos, vende {item:2449}, de tres en tres hasta que repone.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; los herboristas la recogen en las llanuras",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} y cuernos de kodo",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Los kodos de los Baldíos Perdidos ({npc:3234}) deambulan por las llanuras al norte y al oeste de {area:380} y alrededor de {area:388}; cada uno suelta un cuerno. Los herboristas encuentran {item:2449} por todo el norte de {zone:1413}.",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Gacelas enfermas",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Usa el {item:15826} en las gacelas enfermas: pastan al norte del camino que cruza {area:380} de este a oeste.",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296}: usa el ungüento en ellas",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lanza {spell:18960} y habla con {npc:11802}; luego toma el vuelo de {npc:11798} a {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lanza Teletransporte: {zone:1450} y habla con {npc:11802}; luego vuela a {area:702} y toma el portal para subir a {zone:1457}.",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lanza Teletransporte: {zone:1450} y habla con {npc:11802}; luego toma el vuelo de {npc:11798} a {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lanza Teletransporte: {zone:1450}. {npc:11802} está en {area:2361}. Luego vuela a {area:442}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lanza Teletransporte: {zone:1450}. {npc:11802} está en {area:2361}. {npc:11798} lleva a los druidas a {area:1638}; desde allí, vuela a {area:380}.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} ({skill:171} Supplies) in {zone:1453} or on the Auction House."] = "Las flores de hongo lunar crecen en las cuevas de los lechúcicos de las colinas justo al este de {area:442}; los lechúcicos de allí son irritables. La {item:2449} requiere {skill:182}: los herboristas la recogen por todo {zone:1439}; los demás la compran a {npc:1313} (suministros de {skill:171}) en {zone:1453} o en la casa de subastas.",
}
