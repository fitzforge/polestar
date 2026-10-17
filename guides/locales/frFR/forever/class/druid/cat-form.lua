-- French (frFR): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "Votre forme de camouflage et de mêlée : dans Forever, cette suite de quêtes donne {spell:768} au niveau 20, pas le maître.",

	-- Step 1: The Great Cat Spirit
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {area:442} Auberdine
	["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217} se trouve dans {area:1658}. Éolides sans le trajet aérien de Rut'theran : prenez le bateau depuis {area:442}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; apprenez-y le trajet aérien si vous ne l'avez pas.",

	-- Step 3: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Les reliques du Refuge des saisons",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Elfes de la nuit) attend sur la colline sud au-dessus du pont, l'{npc:272054} (Éolides) au sud des ponts jumeaux. Les reliques se trouvent dans {area:2363}, à l'est du lac : quittez votre forme, cliquez sur la statue de l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de félin blanc. Une relique ne donne rien pendant qu'un autre joueur la fouille : patientez un instant et réessayez.",

	-- Step 4: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Retour auprès de {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "Retournez voir {npc:11802} à {area:2361}, puis prenez un vol pour {area:702}.",

	-- Step 5: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Prenez le portail pour monter voir {npc:4217} dans {area:1658}.",

	-- Step 6: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} se trouve sur {area:1639}.",

	-- Step 7: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}.",

	-- Step 8: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {quest:98342} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342} (Taurens) attend sur la colline sud au-dessus du pont, l'{npc:272054} (Éolides) au sud des ponts jumeaux. Les reliques se trouvent dans {area:2363}, à l'est du lac : quittez votre forme, cliquez sur la statue de l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de félin blanc. Une relique ne donne rien pendant qu'un autre joueur la fouille : patientez un instant et réessayez.",

	-- Step 9: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "Retournez voir {npc:11802} à {area:2361}, puis prenez le vol de {npc:11798} pour {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}."] = "Lancez Téléportation : {area:493}. {npc:11802} se trouve à {area:2361}.",
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lancez Téléportation : {area:493}. {npc:11802} se trouve à {area:2361} ; apprenez-y le trajet aérien si vous ne l'avez pas.",
}
