-- Spanish (Spain) (esES): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "Tu forma de sigilo y cuerpo a cuerpo: en Forever, {spell:768} se obtiene a nivel 20 con esta cadena, no con el instructor.",

	-- Step 1: The Great Cat Spirit
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {area:442} Auberdine
	["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217} está en el {area:1658}. Si eres cielonato y no tienes la ruta de vuelo de Rut'theran, toma el barco desde {area:442}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}; aprende allí la ruta de vuelo si no la tienes.",

	-- Step 3: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Las reliquias del Túmulo",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (elfos de la noche) espera en la colina del sur sobre el puente; el {npc:272054} (cielonatos), al sur de los puentes gemelos. Las reliquias están en el {area:2363}, al este del lago: sal de tu forma, pulsa la estatua de la entrada para obtener cinco minutos de sigilo, evita a los espíritus del interior y coge una de cada reliquia; la {item:280680} está a los pies de la estatua del gato blanco. Una reliquia no da botín mientras otro jugador la despoja: espera un momento y vuelve a intentarlo.",

	-- Step 4: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "De vuelta con {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "Vuelve con {npc:11802} en {area:2361} y luego vuela a {area:702}.",

	-- Step 5: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Toma el portal para subir hasta {npc:4217} en el {area:1658}.",

	-- Step 6: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} está en {area:1639}.",

	-- Step 7: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}.",

	-- Step 8: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "El {area:2363}",
	-- {quest:98342} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342} (tauren) espera en la colina del sur sobre el puente; el {npc:272054} (cielonatos), al sur de los puentes gemelos. Las reliquias están en el {area:2363}, al este del lago: sal de tu forma, pulsa la estatua de la entrada para obtener cinco minutos de sigilo, evita a los espíritus del interior y coge una de cada reliquia; la {item:280680} está a los pies de la estatua del gato blanco. Una reliquia no da botín mientras otro jugador la despoja: espera un momento y vuelve a intentarlo.",

	-- Step 9: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "Vuelve con {npc:11802} en {area:2361} y luego toma el vuelo de {npc:11798} a {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}."] = "Lanza Teletransporte: {area:493}. {npc:11802} está en {area:2361}.",
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lanza Teletransporte: {area:493}. {npc:11802} está en {area:2361}; aprende allí la ruta de vuelo si no la tienes.",
}
