-- French (frFR): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "{spell:8946} ne s'apprend plus auprès du maître dans Forever : cette suite de quêtes l'enseigne, avec une sacoche de remèdes en chemin.",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} se trouve dans {area:1658}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Volez ensuite jusqu'à {area:442}.",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Chevauchez vers le nord-est depuis {area:442} jusqu'à {area:445} et remplissez l'{item:15844} à l'entrée de la grotte près des chutes.",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "De retour à {area:442}.",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} et {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Les Floraisons fongiques lunaires ({object:177750}) poussent dans les grottes des séléniens dans les collines juste à l'est d'{area:442} ; les séléniens y sont irritables. {item:2449} requiert {skill:182} : les herboristes la cueillent partout à {zone:1439}, les autres l'achètent à {npc:1313} (Fournitures d'alchimie) à {zone:1453} ou à l'hôtel des ventes.",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Utilisez le {item:15826} sur les {npc:12298}. Ils parcourent {zone:1439}, de {area:456} au nord jusqu'à la frontière d'{zone:1440} au sud.",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298} : utilisez le baume sur eux",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lancez {spell:18960} et allez voir {npc:11802}, puis volez jusqu'à {area:702} et prenez le portail pour monter à {zone:1457}.",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} se trouve sur {area:1639}.",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. {npc:11798} transporte les druides jusqu'à {area:1638} ; de là, volez jusqu'à {area:380}.",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words)
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Depuis {area:380}, chevauchez vers le nord jusqu'à {area:384} et remplissez l'{item:15842} au {object:19464}.",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} se trouve à {area:380}. Pas d'{skill:182} ? {npc:3490}, à quelques pas, vend de la {item:2449}, trois à la fois jusqu'à son réapprovisionnement.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449} ; les herboristes en cueillent dans les plaines",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} et Cornes de kodo",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Des Kodos égarés des Tarides ({npc:3234}) errent dans les plaines au nord et à l'ouest de {area:380} et autour de {area:388} ; chacun lâche une corne. Les herboristes trouvent {item:2449} partout dans le nord de {zone:1413}.",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Gazelles malades",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Utilisez le {item:15826} sur les Gazelles malades : elles paissent au nord de la route qui traverse {area:380} d'est en ouest.",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296} : utilisez le baume sur elles",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lancez {spell:18960} et allez voir {npc:11802}, puis prenez le vol de {npc:11798} jusqu'à {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lancez Téléportation : {zone:1450} et parlez à {npc:11802}, puis prenez un vol pour {area:702} et le portail pour monter à {zone:1457}.",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lancez Téléportation : {zone:1450} et parlez à {npc:11802}, puis prenez le vol de {npc:11798} pour {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Prenez ensuite un vol pour {area:442}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. {npc:11798} emmène les druides à {area:1638} ; de là, prenez un vol pour {area:380}.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} ({skill:171} Supplies) in {zone:1453} or on the Auction House."] = "Les Floraisons fongiques lunaires poussent dans les grottes des séléniens dans les collines juste à l'est de {area:442} ; les séléniens y sont irritables. {item:2449} demande {skill:182} : les herboristes en cueillent partout en {zone:1439}, les autres l'achètent à {npc:1313} (fournitures d'{skill:171}) à {zone:1453} ou à l'hôtel des ventes.",
}
