-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/warlock-felsteed (forever/collectibles/mounts/neutral/warlock-felsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Felsteed"] = "Corcel Vil do Bruxo",
	["Your own mount at 40, summoned anywhere, with no gold spent on a riding horse."] = "Sua própria montaria no nível 40, evocada em qualquer lugar, sem gastar ouro num cavalo.",

	-- Step 1: Summon Felsteed (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "No nível 40, {npc:461}, em {object:2164}, no {object:2101}, envia você a {npc:6251} em {area:392}.",

	-- Step 2: Summon Felsteed (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:5172} in {zone:1455} sends you to {npc:6251} in {area:392}."] = "No nível 40, {npc:5172}, em {zone:1455}, envia você a {npc:6251} em {area:392}.",

	-- Step 3: Summon Felsteed (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:3326} in the {object:172960} sends you to {npc:6251} in {area:392}."] = "No nível 40, {npc:3326}, na {object:172960}, envia você a {npc:6251} em {area:392}.",

	-- Step 4: Summon Felsteed (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 40 {npc:4563} in the {object:36082} sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "No nível 40, {npc:4563}, no {object:36082}, envia você a {npc:6251} em {area:392}. O zepelim de {zone:1420} voa para {zone:1411}.",

	-- Step 5: Strahad Farsan in Ratchet
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6251} in {area:392}"] = "{npc:6251} em {area:392}",
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:380} Crossroads · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {quest:3631} Summon Felsteed
	["{area:392} is on the {zone:1413} coast east of the {area:380}; from the Alliance side, take the boat from {area:35}. {npc:6251}'s follow-up teaches {quest:3631}."] = "{area:392} fica no litoral dos {zone:1413}, a leste da {area:380}; do lado da Aliança, pegue o barco em {area:35}. A missão seguinte de {npc:6251} ensina {quest:3631}.",
}
